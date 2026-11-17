return {
	"snacks.nvim",
	scratch = {
		ft = "markdown",
	},
	keys = {
		{ "<leader>.", function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
		{ "<leader>S", function() Snacks.picker.scratch() end, desc = "Select Scratch Buffer" },
	},
}
