local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (' 󰁂 %d '):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, 'MoreMsg' })
	return newVirtText
end

-- NOTE: nvim-ufo supports only one fallback...
-- We'll have to wait for:
-- "FR: Simplify provider_selector by accepting more than one fallback #256"
-- https://github.com/kevinhwang91/nvim-ufo/issues/256
-- In the meantime instead of:
-- provider_selector = { "lsp", "treesitter", "indent" }
-- We'll use following function
local provider_selector_3way = function(_, ft, _)
	local lspWithOutFolding = { 'markdown', 'zsh', 'css', 'html', 'python', 'json', }
	if vim.tbl_contains(lspWithOutFolding, ft) then
		return { 'treesitter', 'indent' }
	end
	return { 'lsp', 'indent' }
	-- NOTE: lsp provider uses capabilities (lua/kickstart/plugins/blink-lsp.lua:292)
end

return {
	'kevinhwang91/nvim-ufo',
	version = '72d54c31079d38d8dfc5456131b1d0fb5c0264b0',
	-- event = 'VeryLazy',
	lazy = false,
	-- ft = 'markdown',
	-- init = function()
	-- 	vim.o.foldenable = true
	-- 	vim.o.foldlevel = 99
	-- 	vim.o.foldlevelstart = 99
	-- 	-- vim.opt.foldcolumn = 'auto:9'
	-- 	vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
	-- 	-- vim.opt.foldtext = ''
	-- end,
	dependencies = {
		{ 'kevinhwang91/promise-async', lazy = true },
		{ -- disable ugly numbers in statuscolumn
			-- https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1512772530
			"luukvbaal/statuscol.nvim",
			config = function()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({
					relculright = true,
					segments = {
						{ text = { "%s" }, click = "v:lua.ScSa" },
						{ text = { builtin.lnumfunc, "│" }, click = "v:lua.ScLa" },
						{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
					},
				})
			end,
		},
	},
	opts = {
		fold_virt_text_handler = handler,
		provider_selector = provider_selector_3way,
	},
	keys = {
		{
			'zR',
			function()
				require('ufo').openAllFolds()
			end,
			desc = 'open all folds (ufo)',
		},
		{
			'zM',
			function()
				require('ufo').closeAllFolds()
			end,
			desc = 'close all folds (ufo)',
		},
		{
			'zK',
			function()
				require('ufo').peekFoldedLinesUnderCursor()
			end,
			desc = 'Hover on fold or lsp',
		},
	},
}
