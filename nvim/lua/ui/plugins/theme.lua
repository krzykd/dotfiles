return {
	-- Themes tried
	-- { 'folke/tokyonight.nvim' },-- bleh blue tinted gray in tokyonight-day
	-- { 'rebelot/kanagawa.nvim' },
	-- { 'loctvl842/monokai-pro.nvim' } -- Poor snacks support when using monokai-pro-light
	-- { 'projekt0n/github-nvim-theme' }, -- High contrast!, poor color variety :/ (github_light)

	-- { 'sainnhe/everforest', -- vimscript	great light theme, but dark looks ugly on moar
	-- { 'neanias/everforest-nvim'}, lua port
	-- { 'uloco/bluloco.nvim' },

	'catppuccin/nvim',
	name = 'catppuccin',
	priority = 1000,
	version = '2',
	config = function()
		require("catppuccin").setup({
			flavour = "auto", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			integrations = {
				blink_cmp = true,
				gitsigns = true,
				snacks = {
					enabled = true,
					indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
				},
				which_key = true,
				grug_far = true,
			},
			float = {
				transparent = true,
				solid = true,
			},
			color_overrides = {
				latte = {
					rosewater = "#cc7983",
					flamingo = "#bb5d60",
					pink = "#d54597",
					mauve = "#a65fd5",
					red = "#b7242f",
					maroon = "#db3e68",
					peach = "#e46f2a",
					yellow = "#bc8705",
					green = "#1a8e32",
					teal = "#00a390",
					sky = "#089ec0",
					sapphire = "#0ea0a0",
					blue = "#017bca",
					lavender = "#8584f7",
					text = "#444444",
					subtext1 = "#555555",
					subtext0 = "#666666",
					overlay2 = "#777777",
					overlay1 = "#888888",
					overlay0 = "#999999",
					surface2 = "#aaaaaa",
					surface1 = "#bbbbbb",
					surface0 = "#cccccc",
					base = "#ffffff",
					mantle = "#eeeeee",
					crust = "#dddddd",
				},
				mocha = {
					rosewater = "#ffc0b9",
					flamingo = "#f5aba3",
					pink = "#f592d6",
					mauve = "#c0afff",
					red = "#ea746c",
					maroon = "#ff8595",
					peach = "#fa9a6d",
					yellow = "#ffe081",
					green = "#99d783",
					teal = "#47deb4",
					sky = "#00d5ed",
					sapphire = "#00dfce",
					blue = "#00baee",
					lavender = "#abbff3",
					text = "#cccccc",
					subtext1 = "#bbbbbb",
					subtext0 = "#aaaaaa",
					overlay2 = "#999999",
					overlay1 = "#888888",
					overlay0 = "#777777",
					surface2 = "#666666",
					surface1 = "#555555",
					surface0 = "#444444",
					base = "#202020",
					mantle = "#222222",
					crust = "#333333",
				},
			}

		})
		vim.cmd.colorscheme 'catppuccin-nvim'
	end
}
