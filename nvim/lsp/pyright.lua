---@type vim.lsp.Config
return {
	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	single_file_support = true,
	root_markers = {
		'.git',
		'setup.py',
		'pyproject.toml',
		'requirements.txt',
		'.venv'
	},
}
