return {
	{
		'lambdalisue/suda.vim',
		lazy = false,
		version = 'v1.2.4', -- 2024.12.08
		init = function()
			-- NOTE: Disable suda:/// when using vimdiff/nvim -d/pacdiff
			-- vimdiff does not work with suda.vim #32 https://github.com/lambdalisue/vim-suda/issues/32
			-- https://github.com/lambdalisue/vim-suda/issues/23
			if not vim.api.nvim_win_get_option(0, "diff") then
				vim.g.suda_smart_edit = 1
			end
		end
	},
}
