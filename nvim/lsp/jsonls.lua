---@type vim.lsp.Config
return { -- microsoft/vscode-json-languageservice
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { 'json', 'jsonc' },
}
