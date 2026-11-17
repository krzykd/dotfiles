--- markdownlint-cli* replacement in rust
--- also acts as LSP not only linter
---@type vim.lsp.Config
return {

	cmd = { "rumdl", "server" },
	filetypes = { "markdown" },
	root_markers = { ".git" }
}
