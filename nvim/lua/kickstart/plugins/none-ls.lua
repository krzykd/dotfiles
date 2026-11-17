return {
	{
		'nvimtools/none-ls.nvim',
		commit = '550197530c12b4838d685cf4e0d5eb4cca8d52c7',
		-- dependencies = {
		-- 	{
		-- 		"williamboman/mason.nvim",
		-- 		opts = { ensure_installed = { "gomodifytags", "impl" } },
		-- 	},
		-- }
		dependencies = {
			'nvimtools/none-ls-extras.nvim',
		},
		lazy = true,
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local null_ls = require 'null-ls'

			-- custom setup
			null_ls.setup {
				border = 'single',
				sources = {
					require 'none-ls.formatting.jq', -- json formatter
					-- null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.shfmt,
					-- null_ls.builtins.diagnostics.ansiblelint,
					null_ls.builtins.diagnostics.markdownlint_cli2, -- managed by mise
					-- null_ls.builtins.diagnostics.markdownlint.with({
					-- 	extra_args = { '-c', '~/.config/markdownlint/markdownlint_none-ls.yaml' }
					-- }),
					-- null_ls.builtins.diagnostics.terraform_validate,
					-- null_ls.builtins.diagnostics.terragrunt_validate,
					-- null_ls.builtins.diagnostics.trivy, -- Find misconfigurations and vulnerabilities ft: { "terraform", "tf", "terraform-vars" }
					-- null_ls.builtins.diagnostics.yamllint, -- INFO: too much complaining about `found character '\t' that cannot start any token`
				},
				-- configure format on save
				on_attach = function(current_client, bufnr)
					if current_client:supports_method 'textDocument/formatting' then
						vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
						vim.api.nvim_create_autocmd('BufWritePre', {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format { async = false }
							end,
						})
					end
				end,
			}
		end,
	},
}
