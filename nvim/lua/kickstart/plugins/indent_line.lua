return {
	-- NOTE: see alteriks/snacks.nvim - indent

	-- { -- Add indentation guides even on blank lines
	-- 	'lukas-reineke/indent-blankline.nvim',
	-- 	-- Enable `lukas-reineke/indent-blankline.nvim`
	-- 	-- See `:help ibl`
	-- 	main = 'ibl',
	-- 	opts = {},
	-- },
	{
		'saghen/blink.indent',
		version = 'v2.x',
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			mappings = {
				-- which lines around the scope are included for 'ai': 'top', 'bottom', 'both', or 'none'
				border = 'top',
				-- set to '' to disable
				-- textobjects (e.g. `y2ii` to yank current and outer scope)
				object_scope = 'ii',
				object_scope_with_border = 'ai',
				-- motions
				goto_top = '[i',
				goto_bottom = ']i',
			},
		}
	}
}
