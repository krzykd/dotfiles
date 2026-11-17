---@class snacks.picker.Config
return {
	'alteriks/snacks.nvim',
	opts = {
		preset = {
			keys = {
			}
		},
		dashboard = {
			sections = {
				{ section = "header" },
				{

					gap = 1,
					padding = 1,
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{ icon = " ", key = "m", desc = "~/memo Browse", action = ":lua Snacks.dashboard.pick('files', {cwd = '~/memo'})" },
					{
						icon = " ",
						key = "P",
						desc = "Projects",
						action = ":lua Snacks.picker.projects()",
					},
					{
						icon = " ",
						key = "M",
						desc = "~/memo Session",
						action = function()
							vim.api.nvim_set_current_dir(vim.fn.expand("~/memo"))
							require('persistence').load()
						end,
					},
					{
						icon = " ",
						key = "C",
						desc = "Chezmoi",
						action = function()
							vim.api.nvim_set_current_dir(vim.fn.expand("~/.local/share/chezmoi"))
							require("chezmoi.pick").snacks()
						end,
					},
					{ icon = " ", key = "D", desc = "Database connection", action = ":ene | DBUI", },
					{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
					{ icon = " ", key = "s", desc = "Restore Session", action = ':lua require("persistence").select()', },
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" }
				},
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
	},
}
