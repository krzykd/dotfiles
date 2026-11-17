return {
	{
		'folke/trouble.nvim',
		commit = 'bd67efe408d4816e25e8491cc5ad4088e708a69a', -- fixes 'nil' in treesitter.lua
		-- version = '3.x',
		opts = {
			modes = {
				diagnostics_buffer = {
					mode = 'diagnostics', -- inherit from diagnostics mode
					filter = { buf = 0 }  -- filter diagnostics to the current buffer
				}
			}
		},
		cmd = 'Trouble',
		keys = {
			{
				'<leader>xx',
				'<cmd>Trouble diagnostics toggle<cr>',
				desc = 'Diagnostics (Trouble)'
			},
			{
				'<leader>xX',
				'<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
				desc = 'Buffer Diagnostics (Trouble)'
			},
			{
				'<leader>xs',
				'<cmd>Trouble symbols toggle focus=false<cr>',
				desc = 'Symbols (Trouble)'
			},
			{
				'<leader>xl',
				'<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
				desc = 'LSP Definitions / references / ... (Trouble)'
			},
			{
				'<leader>xL',
				'<cmd>Trouble loclist toggle<cr>',
				desc = 'Location List (Trouble)'
			},
			{
				'<leader>xt',
				'<cmd>TodoTrouble toggle<cr>',
				desc = 'Todo List (Trouble)'
			},
			{
				'<leader>xQ',
				'<cmd>Trouble qflist toggle<cr>',
				desc = 'Quickfix List (Trouble)'
			}
		}
	}
}
