---@type vim.lsp.Config
return {
	cmd = { "docker-language-server", "start", "--stdio" },
	single_file_support = true,
	filetypes = { "dockerfile" },
	root_markers = { "Dockerfile" },
}
