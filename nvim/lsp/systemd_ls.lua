---@type vim.lsp.Config
return {
	cmd = { 'systemd-lsp' },
	filetypes = { 'systemd', 'systemd.jinja', 'jinja' },
	single_file_support = true,
}
