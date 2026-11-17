---@class snacks.picker.Config
return {
	{
		'alteriks/snacks.nvim',
		priority = 1000,
		lazy = false,
		-- tag = "v2.31.0",
		branch = "image_d2lang",
		opts = {
			-- indent = { enabled = true, },
			-- lazygit = { enabled = true },
			-- notify = { enabled = true }, -- TODO: vs rcarriga/nvim-notify
			-- quickfile = { enabled = true },
			bufdelete = { enabled = true },
			bigfile = { enabled = true },
			explorer = { enabled = true },
			toggle = { enabled = true },
			statuscolumn = {
				enabled = false,                  -- See: 'luukvbaal/statuscol.nvim' in ~/.config/nvim/lua/kickstart/plugins/ufo.lua
				-- enabled = true,
				left = { 'git', 'mark', 'sign' }, -- priority of signs on the left (high to low)
				right = { 'fold' },               -- priority of signs on the right (high to low)
				folds = {
					open = true,   -- show open fold icons
					git_hl = false -- use Git Signs hl for fold icons
				}
			},
			zen = {
				toggles = {
					dim = false
				}
			}
		},
		keys = {
			{
				"<leader>zz",
				function ()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode"
			},
			{
				"<leader>zZ",
				function ()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom"
			}
		},
		init = function ()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function ()
					-- Create some toggle mappings (UI menu)
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>Us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>Uw")
					Snacks
						.toggle
						.option("listchars", { off = '', on = 'tab:␉·,space:␠', name = "Whitespace(tab/spc)" })
						:map("<leader>UW")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>UL")
					Snacks.toggle.diagnostics():map("<leader>Ud")
					Snacks.toggle.line_number():map("<leader>Ul")
					Snacks
						.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>Uc")
					Snacks.toggle.treesitter():map("<leader>UT")
					Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>Ub")
					Snacks.toggle.inlay_hints():map("<leader>Uh")
					Snacks.toggle.indent():map("<leader>Ug")
					Snacks.toggle.dim():map("<leader>UD")
				end
			})
		end
	}
}
