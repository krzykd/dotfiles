return {
	'folke/flash.nvim',
	-- event = 'VeryLazy',
	tag = 'v2.1.0',
	opts = {
		modes = {
			char = {
				jump_labels = true,
			},
			search = {  -- Disable search, because it sucks. /
				enabled = false,
				wrap = false, -- when query string doesn't match and you're typing fast you're probably end in insert mode or delete some text which sucks bigtime!
				search = {
					incremental = true,
				},
			},
		}
	},
	keys = {
		{ 'f', desc = 'on {char}, to the right' },
		{ 'F', desc = 'on {char}, to the left' },
		{ 't', desc = 'before {char}, to the right' },
		{ 'T', desc = 'after {char}, to the left' },
		{
			'<leader>Fs',
			mode = { 'n', 'x', 'o' },
			function()
				require('flash').jump()
			end,
			desc = 'Flash',
		},
		{
			'<leader>FS',
			mode = { 'n', 'x', 'o' },
			function()
				require('flash').treesitter()
			end,
			desc = 'Flash Treesitter',
		},
		{
			'r',
			mode = 'o',
			function()
				require('flash').remote()
			end,
			desc = 'Remote Flash',
		},
		{
			'R',
			mode = { 'o', 'x' },
			function()
				require('flash').treesitter_search()
			end,
			desc = 'Treesitter Search',
		},
		{
			'<a-s>',
			mode = { 'c' },
			function()
				require('flash').toggle()
			end,
			desc = 'Toggle Flash Search',
		},
	},
}
