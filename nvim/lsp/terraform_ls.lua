---@type vim.lsp.Config
return {
	cmd = { 'terraform-ls', 'serve' },
	filetypes = { 'terraform', 'terraform-vars' },
	settings = {
		terraform = {
			path = '/var/home/alteriks/.local/share/mise/installs/opentofu/1.11.5/tofu'
		}
	},
	-- LSP: Infinite Hang + 100% CPU on typing in Insert Mode #36257
	-- https://github.com/neovim/neovim/issues/36257
	-- https://github.com/hashicorp/terraform-ls/issues/2094
	on_attach = function (client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end
}
