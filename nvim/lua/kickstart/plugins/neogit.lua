return {
	{
		"alteriks/neogit",
		-- "NeogitOrg/neogit",
		-- build = "sed -i 's/    fn()$/    a.void(fn)()/' .local/share/nvim/lazy/neogit/lua/neogit/lib/git/repository.lua",
		opts = {
			disable_signs = true,
			graph_style = "kitty",
			mappings = {
				commit_editor = {
					["<c-c>"] = "Submit",
					["<c-k>"] = "Abort"
				},
				commit_editor_I = {
					["<c-c>"] = "Submit",
					["<c-k>"] = "Abort"
				},
				popup = {
					-- We're remapping defaults, so we can use them with neogit.action
					["c"] = false,
					["p"] = false,
					["P"] = false,
					["<leader>c"] = "CommitPopup",
					["<leader>p"] = "PullPopup",
					["<leader>P"] = "PushPopup"
				}
			}
		},
		config = function (_, opts)
			local neogit = require('neogit')
			neogit.setup(opts)
			
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'NeogitStatus',
				callback = function (ev)
					local ok, wk = pcall(require, 'which-key')
					
					vim.keymap.set('n', 'c', function ()
						neogit.action('commit', 'commit', {})()
					end, { buffer = ev.buf, nowait = true, desc = 'Neogit commit' }
					)
					
					vim.keymap.set('n', 'p', function ()
						neogit.action('pull', 'from_pushremote', {})()
					end, { buffer = ev.buf, nowait = true, desc = 'Neogit Pull' }
					)
					
					vim.keymap.set('n', 'P', function ()
						neogit.action('push', 'to_pushremote', {})()
					end, { buffer = ev.buf, nowait = true, desc = 'Neogit Push' }
					)
					
					if ok then
						wk.add({
							{ 'c', buffer = ev.buf, nowait = true },
							{ 'p', buffer = ev.buf, nowait = true },
							{ 'P', buffer = ev.buf, nowait = true }
						})
					end
				end
			})
		end,
		keys = {
			{ "<leader>gg", '<cmd>Neogit<CR>', desc = "Neogit" },
			{ "<leader>gl", '<cmd>Neogit log<CR>', desc = "Neogit log" },
			{ "<leader>gp", '<cmd>Neogit push<CR>', desc = "Neogit push" },
			{
				"<leader>gn",
				function ()
					local file = vim.fn.expand("%:t") -- just the filename
					require("neogit").open({ cwd = vim.fn.expand("%:p:h") })
					vim.defer_fn(function ()
						vim.fn.search(file, "w")
					end, 200)
				end,
				desc = "Neogit (focus current file)"
			},
			{
				'<leader>gc',
				function ()
					local neogit = require('neogit')
					neogit.action('commit', 'commit', {})()
				end,
				desc = 'Neogit commit'
			}
		}
	}
}
