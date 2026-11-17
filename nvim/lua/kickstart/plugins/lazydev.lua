return {
	-- Configures Lua LSP for your Neovim config, runtime and plugins
	-- used for completion, annotations and signatures of Neovim apis
	'folke/lazydev.nvim',
	version = '1.x',
	ft = 'lua', -- only load on lua files
	cmd = "LazyDev",
	opts = {
		library = {
			{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
			{ path = "LazyVim",            words = { "LazyVim" } },
			{ path = "snacks.nvim",        words = { "Snacks" } },
			{ path = "lazy.nvim",          words = { "LazyVim" } },
		},
	},
	'Bilal2453/luvit-meta', -- used by emmylua_ls
	lazy = true,
}
