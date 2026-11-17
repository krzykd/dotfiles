---@type vim.lsp.Config
return {
	cmd = { 'jinja-lsp' },
	filetypes = { 'yaml.jinja', 'helm.jinja', 'systemd.jinja', 'jinja' },
	single_file_support = true,
}
