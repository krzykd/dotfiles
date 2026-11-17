return {
	{ -- undo tree
		'mbbill/undotree',
		event = 'VeryLazy',
		commit = '0f1c981',
		keys = {
			-- { '<leader>ut', vim.cmd.UndotreeToggle, mode = 'n', opts = { desc = 'Undo Tree' } },
			{ '<leader>ut', vim.cmd.UndotreeToggle, mode = 'n', desc = 'Undo Tree' },
		},
	},
}
