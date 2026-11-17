local function get_schema()
	local schema = require('yaml-companion').get_buf_schema(0)
	if schema.result[1].name == 'none' then
		return ''
	end
	return '󰜢 ' .. schema.result[1].name
end

local function unsaved_count()
	local count = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified and vim.bo[buf].buflisted then
			count = count + 1
		end
	end
	return count
end

local function unsaved_indicator()
	local count = unsaved_count()
	if count > 0 then
		return ' ' .. count .. ' unsaved'
	end
	return ''
end

return {
	'nvim-lualine/lualine.nvim',
	commit = 'b8c23159c0161f4b89196f74ee3a6d02cdc3a955', -- 2025.08.12
	event = 'VeryLazy',
	opts = function ()
		-- https://github.com/LazyVim/LazyVim/blob/13dbe4ad55a4e4b9a3dd345521b359411cdc5879/lua/lazyvim/plugins/ui.lua#L116
		-- PERF: we don't need this lualine require madness 🤷
		local lualine_require = require 'lualine_require'
		lualine_require.require = require

		-- local icons = LazyVim.config.icons

		-- vim.o.laststatus = vim.g.lualine_laststatus

		local opts = {
			options = {
				theme = 'auto',
				-- theme = 'tokyonight-storm',

				-- globalstatus = vim.o.laststatus == 3,
				globalstatus = true,
				disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter' } }
			},
			sections = {
				lualine_a = {
					{
						'mode',
						fmt = function (str)
							return str:sub(1, 1)
						end
					},
					{
						'filename',
						file_status = true, -- displays file status (readonly status, modified status)
						-- use 1<C-G> to show full path, already in keymaps.lua:210
						path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = absolute path with ~
						shorting_target = 80
					}
				},
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				-- lualine_c = { 'filename' },
				lualine_c = {
					-- {
					-- 	'buffers',
					-- 	show_filename_only = true, -- Shows shortened relative path when set to false.
					-- 	hide_filename_extension = false, -- Hide filename extension when set to true.
					-- 	show_modified_status = true, -- Shows indicator when the buffer is modified.
					--
					-- 	mode = 0,                  -- 0: Shows buffer name
					-- 	-- 1: Shows buffer index
					-- 	-- 2: Shows buffer name + buffer index
					-- 	-- 3: Shows buffer number
					-- 	-- 4: Shows buffer name + buffer number
					--
					-- 	max_length = vim.o.columns * 1 / 3,
					-- },
				},
				lualine_x = {
					'encoding',
					'fileformat',
					'filetype',
					{ unsaved_indicator, color = { fg = '#f7768e', gui = 'bold' } },
					get_schema
				},
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
			inactive_sections = {
				lualine_a = { { 'filename', path = 1 } },
				lualine_b = { 'diagnostics' },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { 'neo-tree', 'lazy' }
		}

		-- do not add trouble symbols if aerial is enabled
		-- And allow it to be overriden for some buffer types (see autocmds)

		return opts
	end
}
