---@class snacks.picker.Config
return {
	{
		'alteriks/snacks.nvim',
		priority = 1000,
		opts = {
			picker = {
				sources = {
					projects = {
						-- this just adds top level directories to search for projects
						-- essentially it searches sub directories for the corresponding default patterns
						dev = { "~/git/infra" },
						-- this explicitly sets a specific directory that is a project without the
						-- need to search for a pattern to recognize it
						projects = { "~/.config/nvim" }
					},
					explorer = {
						include = {
							".chezmoi*",
							".env",
							".forgejo",
							".gitignore",
							".sops.yaml"
						}
					},
					grep = {
						include = {
							".chezmoi*",
							".env",
							".gitignore"
						}
					},
					smart = {
						include = {
							".chezmoi*",
							".env",
							".forgejo",
							".gitignore",
							".sops.yaml"
						}
					},
				},
				win = { -- input window
					input = {
						keys = {
							['<Esc>'] = 'close',
							['<C-c>'] = { 'close', mode = 'i' },
							-- ['<CR>'] = 'confirm',
							['G'] = 'list_bottom',
							['gg'] = 'list_top',
							['j'] = 'list_down',
							['k'] = 'list_up',
							['/'] = 'toggle_focus',
							['q'] = 'close',
							["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
							['?'] = 'toggle_help',
							['<a-d>'] = { 'inspect', mode = { 'n', 'i' } },
							['<c-a>'] = { 'select_all', mode = { 'n', 'i' } },
							['<a-m>'] = { 'toggle_maximize', mode = { 'i', 'n' } },
							['<a-p>'] = { 'toggle_preview', mode = { 'i', 'n' } },
							['<a-w>'] = { 'cycle_win', mode = { 'i', 'n' } },
							['<c-v>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
							['<c-s>'] = { 'edit_split', mode = { 'i', 'n' } },
							['<c-q>'] = { 'qflist', mode = { 'i', 'n' } },
							['<c-i>'] = { 'toggle_ignored', mode = { 'i', 'n' } },
							['<c-h>'] = { 'toggle_hidden', mode = { 'i', 'n' } }
						},
						b = {
							minipairs_disable = true
						}
					}
				}
			}
		},
		keys = {

			---@diagnostic disable-next-line: missing-fields
			{
				"<leader><space>",
				-- "<leader><space>",
				function ()
					Snacks.picker.smart {
						multi = { "buffers", "recent", "files" },
						format = "file",
						formatters = {
							file = {
								truncate = 80, -- truncate the file path to (roughly) this length
								filename_first = true
							}
						},
						filter = { cwd = true }
					}
				end,
				desc = "Find smart"
			},
			---@diagnostic disable-next-line: missing-fields
			{
				-- "<leader>ff",
				"<leader><space>",
				function ()
					Snacks.picker.files({
						formatters = {
							file = {
								filename_first = true,
								truncate = 80 -- truncate the file path to (roughly) this length
							}
						}
					})
				end,
				desc = "Find Files"
			},
			{
				"<leader>fr",
				function ()
					Snacks.picker.recent()
				end,
				desc = "Recent"
			},
			---@diagnostic disable-next-line: missing-fields
			{
				"<leader>fz",
				function ()
					Snacks.picker.zoxide({
						finder = "files_zoxide",
						format = "file",
						confirm = function (picker, item)
							picker:close()
							if item then
								Snacks.picker.files({ cwd = item.text })
							end
							local dir = item.file
							vim.fn.chdir(dir)
						end,
						win = {
							preview = {
								minimal = true
							}
						}
					})
				end,
				desc = "Zoxide"
			},

			{
				'<c-tab>',
				function ()
					Snacks.picker.buffers()
				end,
				desc = 'Buffers'
			},
			{
				"<leader>/",
				function ()
					Snacks.picker.grep()
				end,
				desc = "Grep"
			},
			{
				"<leader>:",
				function ()
					Snacks.picker.command_history()
				end,
				desc = "Command History"
			},
			{
				"<leader>us",
				function ()
					Snacks.picker.undo()
				end,
				desc = "Undo via snacks"
			},

			-- find
			{
				"<leader>fc",
				function ()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File"
			},
			-- git
			{
				"<leader>gc",
				function ()
					Snacks.picker.git_log()
				end,
				desc = "Git Log"
			},
			{
				"<leader>gD",
				function ()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)"
			},

			-- { "<leader>gf", function() Snacks.picker.git_files() end,                               desc = "Git Files" }, -- NOTE: overlaps with pathfinder
			{
				"<leader>gs",
				function ()
					Snacks.picker.git_status()
				end,
				desc = "Git Status"
			},
			-- Grep
			{
				"<leader>sb",
				function ()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines"
			},
			{
				"<leader>sB",
				function ()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers"
			}, -- !!!
			{
				"<leader>sg",
				function ()
					Snacks.picker.grep()
				end,
				desc = "Grep"
			},
			{
				"<leader>sw",
				function ()
					Snacks.picker.grep_word()
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" }
			},
			-- search
			{
				'<leader>s"',
				function ()
					Snacks.picker.registers()
				end,
				desc = "Registers"
			},
			-- { "<leader>sa", function() Snacks.picker.autocmds() end,                                               desc = "Autocmds" },
			-- { "<leader>sC", function() Snacks.picker.commands() end,                                               desc = "Commands" },
			{
				"<leader>sd",
				function ()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics"
			},
			{
				"<leader>sD",
				function ()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer Diagnostics"
			},
			{
				"<leader>sh",
				function ()
					Snacks.picker.help()
				end,
				desc = "Help Pages"
			},
			{
				"<leader>sH",
				function ()
					Snacks.picker.highlights()
				end,
				desc = "Highlights"
			},
			{
				"<leader>sj",
				function ()
					Snacks.picker.jumps()
				end,
				desc = "Jumps"
			},
			{
				"<leader>sk",
				function ()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps"
			},
			-- { "<leader>sl", function() Snacks.picker.loclist() end,                                                desc = "Location List" },
			{
				"<leader>sM",
				function ()
					Snacks.picker.man()
				end,
				desc = "Man Pages"
			},
			{
				"<leader>sm",
				function ()
					Snacks.picker.marks()
				end,
				desc = "Marks"
			},
			{
				"<leader>sr",
				function ()
					Snacks.picker.resume()
				end,
				desc = "Resume"
			},
			{
				"<leader>sq",
				function ()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix List"
			},
			{
				"<leader>sv",
				function ()
					Snacks.picker.spelling()
				end,
				desc = "Spelling (vocabulary)"
			},
			{
				"<leader>sC",
				function ()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes"
			},
			{
				"<leader>qp",
				function ()
					Snacks.picker.projects()
				end,
				desc = "Projects"
			},
			-- LSP
			{
				"gd",
				function ()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition"
			},
			{
				"grr",
				function ()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "LSP References"
			},
			{
				"grn",
				function ()
					Snacks.rename.rename_file()
				end,
				nowait = true,
				desc = "Rename File (LSP)"
			},
			{
				"gI",
				function ()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation"
			},
			{
				"gy",
				function ()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition"
			},
			{
				"<leader>ss",
				function ()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols"
			},

			-- map({ 'i', 'n', 'x', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
			{
				-- '<cmd>:lua Snacks.picker.files()<cr>100gs<c-R><c-F>',
				"gF",
				-- function()
				-- Snacks.picker.files({
				-- 	finder = "files",
				-- 	hidden = true,
				-- 	ignored = true,
				-- 	-- regex = false,
				-- 	format = "file",
				-- 	-- search = function(self, picker)
				-- 	-- 	-- return picker:word()
				-- 	-- 	return self.visual and self.visual.text or vim.fn.expand("<cWORD>")
				-- 	-- end,
				-- 	live = false,
				-- 	supports_live = false,
				-- })
				-- 	Snacks.picker.actions.insert(Snacks.picker.files, _, 'insert_file')
				-- end,
				desc = "Go to file under cursor (Snacks)",
				mode = { "n", "x" }
			}
		}
	}
}
