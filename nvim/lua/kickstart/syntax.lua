return {
	{
		'HiPhish/jinja.vim',
		commit = '05373374a288b20845937cbc3a7abda23a2e65d2',
	},

	{ -- Ansible filedetect + run
		'mfussenegger/nvim-ansible',
		commit = 'bba61168b7aef735e7f950fdfece5ef6c388eacf',
		ft = 'yaml', -- Lazy load on yaml filetype, and assign ft = yaml.ansible ;)
	},

	{
		-- helm filedetection, needs to work before helm-ls
		-- NOTE: towolf/vim-helm detects files based on */templates/*.yaml and existance of Chart.yaml in rootdir
		-- qvalentin/helm-ls.nvim doesn't do this, so ~/git/acs/*/templates/*.yamlare detected as helm files
		'towolf/vim-helm',
		ft = 'helm',

		-- 'qvalentin/helm-ls.nvim',
		-- fix for 'yamlls is active when filetype is "helm" #2252'
		-- https://github.com/neovim/nvim-lspconfig/issues/2252
		-- ft = 'helm',
		-- opts = {
		-- 	conceal_templates = {
		-- 		-- enable the replacement of templates with virtual text of their current values
		-- 		enabled = true, -- this might change to false in the future
		-- 	},
		-- 	indent_hints = {
		-- 		-- INFO: doesn't work ;/
		-- 		enabled = false,
		-- 		-- show the hints only for the line the cursor is on
		-- 		only_for_current_line = true,
		-- 	},
		-- }
	},

	-- {
	-- 	"NoahTheDuke/vim-just",
	-- 	ft = { "just" },
	-- },
}
