-- https://github.com/saghen/blink.cmp
-- Documentation site: https://cmp.saghen.dev/

-- INFO: Specify the trigger character(s) used for luasnip
local trigger_char = ';'

-- Place near the top, alongside `trigger_char`
local function in_snippet_trigger()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local before = line:sub(1, col)
	return before:match(vim.pesc(trigger_char) .. '[%w_%.]*$') ~= nil
end

return {
	'saghen/blink.cmp',
	version = 'v1.*',
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{
			"becknik/blink-cmp-luasnip-choice",
			event = 'VeryLazy'
		},
		{
			"mikavilpas/blink-ripgrep.nvim",
			event = 'VeryLazy'
		},
		{
			'moyiz/blink-emoji.nvim',
			event = 'VeryLazy'
		},
		{
			'L3MON4D3/LuaSnip',
			version = 'v2.*',
			event = 'VeryLazy',
			keys = {
				{ '<leader>ll', ':lua require("luasnip.loaders").edit_snippet_files()<CR>', desc = 'Edit lua snippets' }
			},
			build = (function ()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
					return
				end
				return 'make install_jsregexp'
			end)(),
			config = function ()
				local types = require("luasnip.util.types")

				require 'luasnip'.config.setup({
					ext_opts = {
						[types.choiceNode] = {
							active = {
								virt_text = { { " ", "DiagnosticSignOk" } }
							}
						},
						[types.insertNode] = {
							active = {
								virt_text = { { "●", "DiagnosticSignHint" } }
							}
						}
					}
				})
			end,
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				{
					'rafamadriz/friendly-snippets',
					event = 'VeryLazy',
					config = function ()
						require('luasnip.loaders.from_vscode').lazy_load()
						require('luasnip.loaders.from_lua').lazy_load { paths = { './snippets' } }
						require('luasnip.loaders.from_vscode').lazy_load { paths = { './snippets/vscode' } }
						require('luasnip.loaders.from_vscode').lazy_load { paths = { './snippets/ansible' } }
					end
				}
			}
		}
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		enabled = function ()
			-- https://cmp.saghen.dev/recipes.html#disable-per-filetype
			return not vim.tbl_contains({ "typr", "lazy" }, vim.bo.filetype)
		end,
		appearance = {
			nerd_font_variant = 'normal'
		},
		cmdline = {
			enabled = true,
			-- use 'inherit' to inherit mappings from top level `keymap` config
			keymap = { preset = 'cmdline' },
			sources = function ()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == '/' or type == '?' then return { 'buffer' } end
				-- Commands
				if type == ':' or type == '@' then return { 'cmdline' } end
				return {}
			end,
			completion = {
				trigger = {
					show_on_blocked_trigger_characters = {},
					show_on_x_blocked_trigger_characters = {}
				},
				list = {
					selection = {
						-- When `true`, will automatically select the first item in the completion list
						preselect = true,
						-- When `true`, inserts the completion item automatically when selecting it
						auto_insert = true
					}
				},
				-- Whether to automatically show the window when new completion items are available
				menu = { auto_show = true },
				-- Displays a preview of the selected item on the current line
				ghost_text = { enabled = true }
			}
		},
		completion = {
			accept = {
				auto_brackets = { -- auto-insert brackets for functions
					enabled = true
				}
			},
			-- Command line `:`
			menu = {
				border = 'rounded',
				-- Disable fake transparency, fixes different icon sizes in completion menu:
				-- https://github.com/kovidgoyal/kitty/discussions/7533
				winblend = 0,
				min_width = 40,
				max_height = 10,
				draw = {
					align_to = 'cursor',
					columns = {
						{ "kind_icon", "label", "label_description", gap = 1 },
						{ "kind", "source_name", gap = 1 }
					}
				}
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200
			},
			list = {
				selection = {
					auto_insert = false,
					preselect = function (ctx)
						return ctx.trigger.initial_character == trigger_char
					end
				}
			}
		},
		fuzzy = {
			sorts = {
				'exact',     -- Primary sort: by exact matches score
				'score',     -- Secondary sort: by fuzzy matching score
				'sort_text', -- Tertiary sort: by sortText field if scores are equal
				'label'      -- Quaternary sort: by label if still tied
			}
		},
		keymap = {
			preset = 'default',
			['<C-e>'] = { 'hide', 'fallback' }, -- cancel completion, revert to what was written before
			['<C-l>'] = { 'snippet_forward' },
			['<C-h>'] = { 'snippet_backward' },
			['<Up>'] = { 'scroll_documentation_up' },
			['<Down>'] = { 'scroll_documentation_down' },
			['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' }
		},
		signature = {
			enabled = true,
			window = { border = 'single' }
		},
		snippets = { preset = 'luasnip' },
		sources = {
			default = { 'choice', 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'ripgrep', 'emoji' },
			per_filetype = {
				-- org = { 'orgmode' },
				sql = { 'snippets', 'dadbod', 'buffer' }
			},
			providers = {
				-- Adds support for LuaSnip (becknik/blink-cmp-luasnip-choice)
				-- https://github.com/saghen/blink.cmp/issues/743
				-- This plugin won't be needed when saghen/blink.cmp v2 is released
				-- Enabling it now doesn't make sense needs 'main' branches of both saghen/blink.cmp and L3MON4D3/LuaSnip
				-- https://github.com/saghen/blink.cmp/pull/2238
				choice = {
					name = 'LuaSnip Choice Nodes',
					module = 'blink-cmp-luasnip-choice',
					opts = {},
					score_offset = 120,
					transform_items = function (ctx, items)
						for _, item in ipairs(items) do
							item.kind_icon = ''
							item.kind_name = 'Choice'
							item.source_name = nil
						end
						return items
					end
				},
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
					score_offset = 110
				},
				cmdline = {
					min_keyword_length = function (ctx)
						-- when typing a command, only show when the keyword is 3 characters or longer
						if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 3 end
						return 0
					end
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100
				},
				lsp = {
					name = 'lsp',
					enabled = true,
					module = 'blink.cmp.sources.lsp',
					score_offset = 90, -- the higher the number, the higher the priority
					fallbacks = {}     -- By default, the buffer source will only show when the LSP source is disabled or returns no items.
				},
				snippets = {
					name = 'snippets',
					enabled = true,
					max_items = 10,
					module = 'blink.cmp.sources.snippets',
					score_offset = 200,
					-- Trigger snippets on semicolon ';'
					-- Entries in FQCN format have higher priority than their description
					-- Works with ';copy' ';.copy' -> ansible.builtin.copy
					should_show_items = function (ctx)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local line = vim.api.nvim_get_current_line()
						local before = line:sub(1, col)
						-- Matches ";", ";copy", ";.copy", ";ansible.builtin.copy", etc.
						-- Breaks on whitespace, so a plain "." elsewhere in the line won't trigger it.
						return before:match(vim.pesc(trigger_char) .. '[%w_%.]*$') ~= nil
					end,
					transform_items = function (_, items)
						-- Detect if user typed ;.something → wants FQCN only
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local keyword = vim.api.nvim_get_current_line():sub(1, col):match('[%w_%.]+$') or ''
						local fqcn_only = keyword:sub(1, 1) == '.'

						local result = {}
						for _, item in ipairs(items) do
							-- Prepend trigger char (existing logic)
							if item.textEdit then
								item.textEdit.newText = trigger_char .. (item.textEdit.newText or '')
							end
							item.insertText = trigger_char .. (item.insertText or item.label)

							local label = item.label or ''
							local is_fqcn = label:find('%.') ~= nil -- has dot → FQCN prefix

							-- ;.copy → drop non-FQCN items entirely
							if fqcn_only and not is_fqcn then
								goto continue
							end

							if is_fqcn then
								-- Use only the last component ("copy") as filterText so
								-- ";copy" scores FQCN items equally to the verbose ones,
								-- letting sortText be the tiebreaker
								item.filterText = label:match('[^%.]+$') or label
								item.sortText = '0_' .. label                     -- FQCN first
							else
								item.sortText = '1_' .. label
							end

							table.insert(result, item)
							::continue::
						end
						return result
					end,
					override = {
						get_trigger_characters = function (_)
							return { trigger_char }
						end
					}
					--
					-- End trigger snippets
				},
				path = {
					name = 'Path',
					module = 'blink.cmp.sources.path',
					score_offset = 125,
					fallbacks = {},
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function (context)
							return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
						end,
						show_hidden_files_by_default = true
					}
				},
				buffer = {
					name = 'Buffer',
					-- enabled = true,
					enabled = function ()
						return not in_snippet_trigger()
					end,
					max_items = 5,
					module = 'blink.cmp.sources.buffer',
					min_keyword_length = 3,
					score_offset = 20,
					opts = {
						-- filter all  "normal" buffers
						get_bufnrs = function ()
							return vim.tbl_filter(function (bufnr)
								return vim.bo[bufnr].buftype == ''
							end, vim.api.nvim_list_bufs())
						end
					},
					transform_items = function (_ctx, items)
						for _, item in ipairs(items) do
							item.kind_icon = ''
							-- item.kind_name = 'Buffer'
						end
						return items
					end
				},
				ripgrep = {
					-- PERF: disable if slowdown is encountered
					-- ie in ~/.config/nvim
					-- configure root project
					module = "blink-ripgrep",
					name = "Ripgrep",
					score_offset = 18,
					opts = {
						prefix_min_len = 4
					}
				},
				-- https://github.com/moyiz/blink-emoji.nvim
				-- Trigger on colon ':'
				emoji = {
					module = 'blink-emoji',
					name = 'Emoji',
					score_offset = 15,       -- the higher the number, the higher the priority
					min_keyword_length = 2,  -- helps with triggering too soon
					opts = { insert = true } -- Insert emoji (default) or complete its name
				}
			}
		}
	}
}
