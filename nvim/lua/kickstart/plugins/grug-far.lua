return {
	-- Find and replace
	'MagicDuck/grug-far.nvim',
	version = '1.6.x',
	opts = {
		keymaps = {
			replace = { n = '<localleader>R' }
		}
	},
	keys = {
		{
			'<leader>rg',
			function ()
				require('grug-far').toggle_instance({
					instanceName = "far",
					staticTitle = "Find and Replace"
				})
			end,
			desc = 'Find and Replace (split)'
		},
		{
			'<leader>rt',
			function ()
				require('grug-far').toggle_instance({
					windowCreationCommand = "tab split",
					instanceName = "fartab",
					staticTitle = "Find and Replace"
				})
			end,
			desc = 'Find and Replace (tabnew)'
		}
	}
}
