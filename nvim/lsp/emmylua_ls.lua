-- INFO: additional config inside ~/.config/nvim/.emmyrc.json
return {
	cmd = { "emmylua_ls" },
	settings = {
		Lua = {
			-- completion = {
			-- 	callSnippet = 'Replace',
			-- },
			-- runtime = {
			-- 	version = "LuaJIT",
			-- },
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.tbl_extend(
					"keep",
					{ vim.env.VIMRUNTIME, "${3rd}/luv/library" },
					vim.api.nvim_get_runtime_file("", true)
				),
			},
		},
	},
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".emmyrc.json",
		".luacheckrc",
		".git",
	},

}
