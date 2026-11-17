return {
	'xvzc/chezmoi.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ '<leader>cz', function() require("chezmoi.pick").snacks() end, desc = 'Chezmoi' },
	}
}
