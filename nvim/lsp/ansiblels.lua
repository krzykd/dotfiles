---@type vim.lsp.Config
return {
	cmd = { 'ansible-language-server', '--stdio' },
	filetypes = { 'yaml.ansible' },
	-- single_file_support = true,
	root_markers = {
		'.git',
		'ansible.cfg'
	},
	settings = {
		ansible = {
			redhat = {
				telemetry = {
					enabled = false
				}
			},
			validation = {
				enabled = true,
				lint = {
					enabled = true
					-- Default args: /usr/bin/ansible-lint --offline --nocolor -f codeclimate
					-- overriding config file disables using project config `.ansible-lint.yml` ie ~/git/acs
					-- arguments = "-c /home/alteriks/.config/ansible-lint/ansible-lint.yml"
				}
			}
		}
	}
}
