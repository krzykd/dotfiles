---@type vim.lsp.Config
return { -- "Go please" official LSP
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gosum", "gotmpl" },
	root_markers = {
		"go.mod",
		"go.sum",
	},
	settings = {
		gopls = {
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				fieldalignment = true,
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
			},
			completeUnimported = true,
			directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
			gofumpt = true,
			semanticTokens = true,
			staticcheck = true,
			usePlaceholders = true,
		},
	},
}
