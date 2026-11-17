-- NOTE: Strip escaped punctuation signs from help `K`
-- Ansible LSP prepends `.` \., \(, \_.
local function unescape_markdown_punct(text)
	-- Don't touch backslashes inside fenced code blocks (could be real
	-- regex/path backslashes), only in prose.
	local lines = vim.split(text, "\n", { plain = true })
	local in_fence = false
	for i, line in ipairs(lines) do
		if line:match("^%s*```") then
			in_fence = not in_fence
		elseif not in_fence then
			lines[i] = line:gsub("\\(%p)", "%1")
		end
	end
	return table.concat(lines, "\n")
end

local convert = vim.lsp.util.convert_input_to_markdown_lines
vim.lsp.util.convert_input_to_markdown_lines = function (input, contents)
	if type(input) == "string" then
		input = unescape_markdown_punct(input)
	elseif type(input) == "table" then
		if input.value then -- MarkupContent { kind, value } or MarkedString { language, value }
			input.value = unescape_markdown_punct(input.value)
		elseif input[1] ~= nil then -- MarkedString[]
			for i, item in ipairs(input) do
				if type(item) == "string" then
					input[i] = unescape_markdown_punct(item)
				elseif type(item) == "table" and item.value then
					item.value = unescape_markdown_punct(item.value)
				end
			end
		end
	end
	return convert(input, contents)
end

-- NOTE: autoinstall feature (WhoIsSethDaniel/mason-tool-installer.nvim invokes williamboman/mason.nvim)
-- We're adding another list of LSPs, because (vim.lsp.enable)
-- LSP server names are not compliant with https://mason-registry.dev/registry/list ie
-- ansiblels -> ansible-language-server
-- bashls -> bash-language-server

local autoinstall_servers = {
	'ansible-language-server',
	'bash-language-server',
	'css-lsp',
	'docker-language-server', -- also for docker-compose
	'emmylua_ls',
	'gopls',
	'eslint_d',               -- javascript/typescript, used by mfussenegger/nvim-lint
	'helm-ls',
	'html-lsp',
	'jinja-lsp',              -- TODO:
	'json-lsp',
	'just-lsp',
	'kdlfmt',
	'kulala-fmt',             -- http
	'marksman',
	'tofu-ls',
	-- 'pylsp',
	'pyright',                -- TODO: npm+microsoft vs pylsp python+community
	'rumdl',                  -- markdownlint-cli* replacement in rust
	'sqls',
	'shellcheck',
	'shfmt',
	'stylua',
	'systemd-lsp',
	'tinymist',               -- typst
	-- 'terraform-ls',
	'tsgo',
	'yamlfmt',
	'yaml-language-server'    -- yamlls
}
vim.lsp.config('*', {
	root_markers = { '.git' }
})
vim.lsp.enable({
	'ansiblels',
	'bashls',
	'cssls',
	'docker_compose',
	'dockerls',
	'emmylua_ls', -- replaces 'luals'
	'gopls',
	'helmls',
	'html',
	'jinja_lsp',  -- TODO:
	'jsonls',
	'just',
	'marksman',
	'tofu_ls',
	-- 'pylsp',
	'pyright',    -- TODO: npm+microsoft vs pylsp python+community
	'rumdl',      -- markdownlint-cli* replacement in rust
	'sqls',
	'systemd_ls',
	'typst',      -- 'tinymist',   -- typst
	-- 'terraform_ls',
	'ts_ls',
	'yamlls'
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts

vim.keymap.set("n", "<leader>dt", function ()
	-- TODO: merge with other LSP keymaps. WHERE?!
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle Diagnostics' }
)

-- Inlay hints nice to have for GO
vim.lsp.inlay_hint.enable()
-- TODO: how to enable toggle
-- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
-- 	map('<leader>lh', function()
-- 		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
-- 	end, 'Toggle Inlay [H]ints')
-- end

vim.diagnostic.config {
	-- Show float window when `Next Error` (`]e`)
	severity_sort = true,
	float = { source = 'if_many' },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = { -- show icon in signcolumn instead of E/W/I/H, needs nerdfont
		text = {
			[vim.diagnostic.severity.ERROR] = '󰅚 ',
			[vim.diagnostic.severity.WARN] = '󰀪 ',
			[vim.diagnostic.severity.INFO] = '󰋽 ',
			[vim.diagnostic.severity.HINT] = '󰌶 '
		}
	}
		or {},

	-- Inlay diagnostics from LSP servers
	virtual_text = { current_line = true }
	-- virtual_lines = { current_line = true } -- moves text around :/ https://youtu.be/ZiH59zg59kg?t=205
}

-- Cleanup ~/.local/state/nvim/lsp.log
vim.api.nvim_create_autocmd("VimLeavePre", {
	desc = "Truncate LSP log on exit",
	callback = function ()
		local log_path = vim.lsp.log.get_filename()
		local f = io.open(log_path, "w")
		if f then f:close() end
	end
})

return {
	{
		'mason-org/mason.nvim',
		version = 'v2.x',
		-- NOTE: mason needs to be launched at begining to add binaries to Neovim's PATH
		-- either `cmd` nor `event = VeryLazy` doesn't work
		config = true
	},
	{
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		opts = {
			ensure_installed = autoinstall_servers
		}
	},
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"alteriks/snacks.nvim",
				opts = {
					terminal = {}
				}
			}
		},
		event = "LspAttach",
		opts = {
			picker = "snacks"
		},
		keys = {
			{
				'<leader>ca',
				function ()
					require("tiny-code-action").code_action()
				end,
				desc = ' Code Actions'
			}
			-- vim.keymap.set({ "n", "x" }, "<leader>ca", function() require("tiny-code-action").code_action() end, { noremap = true, silent = true })
		}
	}
}
