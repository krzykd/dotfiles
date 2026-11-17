local version = require("vim.version")
return {
	"mistweaverco/kulala.nvim",
	version = "v5.x",
	keys = {
		{ "<leader>Cs", desc = "Send request" },
		{ "<leader>Ca", desc = "Send all requests" },
		{ "<leader>Cb", desc = "Open scratchpad" },
	},
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		global_keymaps_prefix = "<leader>C",
		kulala_keymaps_prefix = "",
	},
}
