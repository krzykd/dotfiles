return {
	{ -- Useful plugin to show you pending keybinds.
		'folke/which-key.nvim',
		event = 'VeryLazy',
		tag = 'v3.17.0',
		opts = {
			preset = 'modern',
			icons = {
				group = '  ',
			},
			-- win = {
			--   wo = {
			--     winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			--   },
			-- },
			sort = { 'local', 'order', 'manual', 'group', 'mod' },
		},
		config = function(_, opts) -- This is the function that runs, AFTER loading
			require('which-key').setup(opts)

			-- Document existing key chains
			require('which-key').add {
				{
					{ '<leader>c', group = '[c]ode', icon = { icon = '  ', color = 'cyan' } },
					{ '<leader>cf', group = '[f]ormat/lint', icon = { icon = '󰊄 ', color = 'cyan' } },
					{ '<leader>cft', icon = { icon = ' ', color = 'cyan' } }, -- toggle for Conform lint
					{ '<leader>C', group = '[C]url/Kulala', icon = { icon = '󰇚  ', color = 'cyan' } },
					{ '<leader>d', group = '[d]ebug', icon = { icon = ' ', color = 'cyan' } },
					{ '<leader>f', group = '[f]ind', icon = { icon = ' ', color = 'green' } },
					{ '<leader>F', group = '[F]lash', icon = { icon = ' ', color = 'yellow' } },
					{ '<leader>g', group = '[g]it', icon = { icon = '󰊢 ', color = 'orange' } },
					{ '<leader>l', group = '[l]sp', icon = { icon = ' ', color = 'yellow', hl = 'azure' } },
					{ '<leader>m', group = '[m]arkdown', icon = { icon = ' ', color = 'grey' } },
					{ '<leader>mT', group = '[T]able of Contents', icon = { icon = ' ', color = 'grey' } },
					{ '<leader>n', group = '[n]oice' },
					{ '<leader>r', group = '[r]eplace', icon = { icon = '󰛔 ', color = 'red' } },
					{ '<leader>s', group = '[s]nacks', icon = { icon = '󱥰 ', color = 'yellow' } },
					{ '<leader>t', group = '[t]oggle', icon = { icon = ' ' } },
					{ '<leader>x', group = '[T]rouble', icon = { icon = '󰲉 ', color = 'red' } },
					{ '<leader>u', group = '[u]ndo', icon = { icon = '󰕌 ', color = 'red' } },
					{ '<leader>U', group = '[U]I', icon = { icon = ' ', color = 'yellow' } },
					{ '<leader>q', group = '[q]uit', icon = { icon = '󰗼 ', color = 'red' } },
					-- { '<leader>w', group = '[W]orkspace' },
					{ '<leader>h', group = 'Git [h]unk', mode = { 'n', 'v' } },
				},
			}
		end,
	},
}
