return {
	{
		'dhruvasagar/vim-table-mode',
		commit = 'e156dbbedce0bbf61c0919db7678fa246fabd616',
		config = function (_, opts)
			vim.g.table_mode_disable_mappings = 1
			vim.g.table_mode_disable_tableize_mappings = 1
			vim.keymap.del("n", "<leader>tm")
		end,
		keys = {
			{ "<leader>mtt", "<cmd>TableModeToggle<CR>", desc = "Toggle Table Mode" },
			{ "<leader>mtf", "<cmd>TableModeRealign<CR>", desc = "Realign Table" },
			-- { "<leader>mti", "<cmd>TableModeInsertRow<CR>",   desc = "Insert Table Row Below" },
			{ "<leader>mtd", "<Plug>(table-mode-delete-row)", desc = "Delete Table Row" },
			{ "<leader>mtca", "<Plug>(table-mode-insert-column-after)", desc = "Insert Table Column After" },
			{ "<leader>mtcb", "<Plug>(table-mode-insert-column-before)", desc = "Delete Table Column Before" },
			{ "<leader>mtcd", "<Plug>(table-mode-delete-column)", desc = "Delete Table Column" },
			{ "<leader>mta", "<Plug>(table-mode-add-formula)", desc = "Add formula" },
			{ "<leader>mte", "<Plug>(table-mode-eval)", desc = "Evaluate formula" },
			{ "<leader>mts", "<cmd>TableSort<CR>", desc = "Table Sort", mode = { "n", "v" } },
			{ "<leader>mtS", "<cmd>TableSort!<CR>", desc = "Table Sort Reverse", mode = { "n", "v" } }
		}
	},
	{
		"obsidian-nvim/obsidian.nvim",
		-- https://github.com/obsidian-nvim/obsidian.nvim/issues/268
		version = "3.x", -- recommended, use latest release instead of latest commit
		lazy = true,
		cmd = { "Obsidian" },
		-- lazy = true,
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim"
		},
		event = {
			"BufReadPre " .. vim.fn.expand "~" .. "/memo/*.md",
			"BufNewFile " .. vim.fn.expand "~" .. "/memo/*.md"
		},
		opts = {
			attachments = {
				folder = './media'
			},
			checkbox = {
				enabled = true,
				create_new = false,
				order = { " ", "~", "!", ">", "x" }
			},
			completion = {
				-- Trigger completion at 2 chars.
				min_chars = 2,
				-- Set to false to disable new note creation in the picker
				create_new = true
			},
			legacy_commands = false,
			footer = {
				enabled = true
			},
			open = {
				func = function (uri)
					vim.ui.open(uri)
					vim.fn.system("niri_focus_window.sh obsidian")
				end
			},
			picker = {
				name = 'snacks.picker'
			},
			statusline = { -- depracated in favor of footer
				enabled = false
			},
			templates = {
				folder = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				-- A map for custom variables, the key should be the variable and the value a function.
				-- Functions are called with obsidian.TemplateContext objects as their sole parameter.
				-- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
				substitutions = {},
				-- A map for configuring unique directories and paths for specific templates
				--- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
				customizations = {}
			},
			ui = {
				enable = true,             -- set to false to disable all additional syntax features
				ignore_conceal_warn = true -- set to true to disable conceallevel specific warning
				-- update_debounce = 200,  -- update delay after a text change (in milliseconds)
				-- max_file_length = 5000, -- disable UI features for files with more than this many lines
			},
			workspaces = {
				{
					name = "vault",
					path = "~/memo"
				}
			}
		},
		keys = {
			{ '<leader>mb', '<cmd>Obsidian backlinks<cr>', desc = ' Obsidian [b]acklinks' },
			{ '<leader>m|', '<cmd>Obsidian follow_link vsplit<cr>', desc = ' Obsidian follow link + vsplit' },
			{ '<leader>m_', '<cmd>Obsidian follow_link hsplit<cr>', desc = ' Obsidian follow link + hsplit' },
			{ '<leader>mg', '<cmd>Obsidian search<cr>', desc = ' Obsidian grep' },
			{ '<leader>mn', '<cmd>Obsidian new<cr>', desc = ' Obsidian [n]ew file' },
			{ '<leader>mO', '<cmd>Obsidian open<cr>', desc = ' Obsidian [o]pen in app' },
			{ '<leader>mu', '<cmd>Obsidian links<cr>', desc = ' Obsidian [u]rls' },
			-- { '<leader>mt',        '<cmd>Obsidian new_from_template<cr>',  desc = ' Obsidian new file from template' },
			{ '<leader>mT', '<cmd>Obsidian template<cr>', desc = ' Obsidian insert [t]emplate' },
			{ '<leader>m1', '<cmd>Obsidian toc<cr>', desc = ' Obsidian Table of Contents' },
			{ '<leader>m#', '<cmd>Obsidian tags<cr>', desc = ' Obsidian [t]ags' },
			{ '<leader>m<leader>', '<cmd>Obsidian quick_switch<cr>', desc = ' Obsidian files' },
			{ '<leader>mp', '<cmd>Obsidian paste_img<cr>', desc = ' Obsidian [p]aste image' },
			{ 'grr', '<cmd>Obsidian backlinks<cr>', desc = 'references (Obsidian backlinks)' }
			-- { 'gf',                '<cmd>Obsidian follow_link <cr>',       desc = 'Obsidian follow link' },
			-- WARN: doesn't override default gO { 'gO',                '<cmd>Obsidian toc<cr>',                desc = ' Obsidian Table of Contents' },
		},
		config = function (_, opts)
			require('obsidian').setup(opts)
			-- INFO: Use default vim keybinding for `goto file`
			-- https://github.com/obsidian-nvim/obsidian.nvim/issues/359#issuecomment-3190857374
			vim.keymap.set(
				"n", "gf",
				function ()
					if require("obsidian").util.cursor_link() then
						return "<cmd>Obsidian follow_link<cr>"
					else
						return "gf"
					end
				end,
				{
					expr = true,
					desc = "[g]o to [f]ile under cursor (Obsidian)"
				}
			)
			vim.keymap.set(
				"n", "grr",
				function ()
					if require("obsidian").util.cursor_link() then
						return "<cmd>Obsidian backlinks<cr>"
					else
						return "gf"
					end
				end,
				{
					expr = true,
					desc = "[g]o to [r]references under cursor (Obsidian)"
				}
			)
		end
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" }
		},
		opts = {
			-- Your setup opts here
		}
	}
}
