return {
	-- 'lucidph3nx/nvim-sops',
	-- commit = 'cb2209562d00ef8c6c88bdec836d9edb8fbb96ef',
	-- cmd = { 'SopsDecrypt', 'SopsEncrypt' },
	-- opts = {
	-- },
	-- 	{
	--   'atmask/sops.nvim',
	--   ft = { 'yaml', 'json' },  -- Lazy load on YAML/JSON files
	-- }
	{
		"alteriks/sops-edit.nvim",
		build = ":RocksInstall sops-edit.nvim",
		config = function ()
			require("sops_edit").setup({
				sops_patterns = {
					"%.sops%.ya?ml$",
					"%.sops%.json$",
					"%.sops%.env$",
					"%.sops%.ini$"
				},
				verbose = false
			})
		end
	}
	-- {
	-- 	'lemarsu/sops.nvim',
	-- }
	-- {
	-- 	"trixnz/sops.nvim",
	-- 	-- lazy = false
	-- },
}
