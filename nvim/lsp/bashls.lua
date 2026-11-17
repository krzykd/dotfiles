---@type vim.lsp.Config
return { -- IDE-like experience for bash scripts to most editors. This is based on the Tree Sitter parser and supports explainshell, shellcheck and shfmt.
	cmd = { 'bash-language-server', 'start' },
	filetypes = { 'sh', 'bash', 'zsh' },
	settings = {
		bashIde = {
			-- Glob pattern for finding and parsing shell script files in the workspace.
			-- Used by the background analysis features across files.

			-- Prevent recursive scanning which will cause issues when opening a file
			-- directly in the home directory (e.g. ~/foo.sh).
			--
			-- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
			globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
		},
	},
	cmd_env = {
		GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
	},
}
