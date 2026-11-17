return {
	{
		"esmuellert/codediff.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		version = 'v2.x',
		cmd = "CodeDiff",
		keys = {
			{ "<leader>gd", '<cmd>CodeDiff<cr>', desc = "CodeDiff Toggle" },
		},
		opts = {
			diff = {
				-- Useful for ansible.yaml
				ignore_trim_whitespace = true, -- Ignore leading/trailing whitespace changes (like diffopt+=iwhite)
			},
			keymaps = {
				view = {
					toggle_stage = "s",
				}
			}
		}
	}
}
