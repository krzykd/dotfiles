return {
	-- Use zen mode to copy when OSC52 is unavailable
	-- This plugin supports changing font size in terminal(kitty)
	'folke/zen-mode.nvim',
	version = '1.4.1',
	opts = {
		window = {
			options = {
				signcolumn = 'no',  -- disable signcolumn
				number = false,     -- disable number column
				relativenumber = false, -- disable relative numbers
				cursorline = false, -- disable cursorline
				cursorcolumn = false, -- disable cursor column
				foldcolumn = '0',   -- disable fold column
				-- list = false, -- disable whitespace characters
			},
		},
		plugins = {
			kitty = {
				enabled = true,
				font = '+4', -- font size increment
			},
		},
	},
	keys = {
		{ "<leader>zp", '<cmd>ZenMode<CR>', desc = "Toggle Zen Presentation (zen.nvim)" },
	}
}
