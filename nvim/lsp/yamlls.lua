---@type vim.lsp.Config
return {
	cmd = { "yaml-language-server", "--stdio" },
	single_file_support = true,
	root_markers = {
		'.git'
	},
	-- trace = { server = "verbose" },
	capabilities = {
		workspace = {
			didChangeConfiguration = {
				dynamicRegistration = true
			}
		}
	},
	before_init = function (_, config)
		local ok, schemastore = pcall(require, 'schemastore')
		if ok then
			config.settings.yaml.schemas = schemastore.yaml.schemas()
		end
	end,
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = ""
			},
			schemas = {}, -- populated by before_init
			format = { enabled = true },
			validate = true,
			completion = true,
			hover = true
		},
		redhat = { telemetry = { enabled = false } }
	},
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.ansible" }
}
