local diagnostics_icons = {
	Error = ' ',
	Warn = ' ',
	Hint = ' ',
	Info = '󰗖 ',
}

local function diagnostic_indicator(_, _, diagnostics, _)
	local result = {}
	local symbols = {
		error = diagnostics_icons.Error,
		warning = diagnostics_icons.Warn,
		info = diagnostics_icons.Info,
		hint = diagnostics_icons.Hint
	}
	for name, count in pairs(diagnostics) do
		if symbols[name] and count > 0 then
			table.insert(result, symbols[name] .. count)
		end
	end
	local res = table.concat(result, ' ')
	return #res > 0 and res or ''
end
return {
	'akinsho/bufferline.nvim',
	event = "VeryLazy",
	version = 'v4.9.1',
	-- dependencies = {
	-- 	'nvim-tree/nvim-web-devicons',
	-- },
	opts = {
		options = {
			always_show_bufferline = true,
			indicator = { style = 'underline' },

			diagnostics = 'nvim_lsp',
			diagnostics_indicator = diagnostic_indicator,
			highlights = {
				fill = { bg = "#2F1F36" },
				background = { bg = "#2F1F36" },
			},
			offsets = {
				{
					filetype = 'snacks_layout_box',
					text = '󰙅  File Explorer',
					separator = true,
					-- 		filetype = 'neo-tree',
					-- 		text = 'Neo-tree',
					-- 		highlight = 'Directory',
					-- 		text_align = 'left',
				},
			},
		},
	},
	config = function(_, opts)
		require('bufferline').setup(opts)
		-- highlights = require('catppuccin.groups.integrations.bufferline').get()

		-- Fix bufferline when restoring a session
		vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
}
