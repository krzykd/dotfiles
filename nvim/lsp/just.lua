---@type vim.lsp.Config
return {
	cmd = { "just-lsp" },
	filetypes = { 'just', },
	single_file_support = true,
	docs = {
		description = [[
https://github.com/terror/just-lsp

`just-lsp` is an LSP for just built on top of the tree-sitter-just parser.
]],
	},
}
