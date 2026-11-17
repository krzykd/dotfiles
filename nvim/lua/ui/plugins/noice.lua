return {
	'folke/noice.nvim',
	event = 'VeryLazy',
	commit = 'c86aea584d98be7ee1167ce4d4ef946fbd7f3ae0', -- 2025.10.24
	keys = {
		{ '<leader>na', '<cmd>NoiceAll<cr>',     desc = 'Noice [a]ll' },
		{ '<leader>nd', '<cmd>NoiceDismiss<cr>', desc = 'Noice [d]ismiss all' },
		{ '<leader>ne', '<cmd>NoiceErrors<cr>',  desc = 'Noice [e]rrors' },
		{ '<leader>nh', '<cmd>NoiceHistory<cr>', desc = 'Noice [h]istory' },
		{ '<leader>nt', '<cmd>NoicePick<cr>',    desc = 'Noice [t]elescope' },
		{ '<leader>nl', '<cmd>NoiceLast<cr>',    desc = 'Noice [l]ast message' },
	},
	opts = {
		-- add any options here
		views = {
			mini = {
				position = { -- fixes lsp position
					row = -2,
					col = "100%",
				},
			},
			cmdline_popup = {
				position = {
					row = 3,
					-- col = '70%',
				},
			},
			popupmenu = {
				relative = 'editor',
				position = { -- NOTE: this doesn't work with blink-cmp, drawer is offset
					row = 6,
					-- col = '70%',
				},
				size = {
					width = 60,
				},
				border = {
					style = 'single',
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = { Normal = 'Normal', FloatBorder = 'NoiceCmdlinePopupBorder' },
				},
			},
		},
		presets = {
			bottom_search = true,
		},
		-- cmdline = {
		--   enabled = true,
		-- },
		notify = {
			enabled = true,
		},
		messages = {
			enabled = false,
		},
		popupmenu = {
			enabled = true,
		},
		lsp = {
			progress = {
				enabled = true,
			},
			signature = {
				enabled = false,
			},
			hover = {
				enabled = false,
			},
			messages = {
				enabled = false,
			},
		},
		health = {
			checker = true, -- Disable if you don't want health checks to run
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		'MunifTanjim/nui.nvim',
	},
}
