--- Removes the •••••• part.
-- vim.o.fillchars = "fold: ";

return {
	'OXY2DEV/markview.nvim',
	-- NOTE: lazy loading needs to be disabled.
	-- This plugin does its own shenanigans with highlights
	-- ft = 'markdown',
	lazy = false,
	version = 'v28.x',
	-- Codeblock fence doesn't render https://github.com/OXY2DEV/markview.nvim/issues/332#issuecomment-3360949093
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"markdown",
			},
			callback = function(args)
				require("markview").actions.set_query(args.buf)
			end,
			once = true,
		})
	end,
	config = function()
		require('markview').setup {
			preview = {
				modes = { "i", "n", "no", "c" },

				hybrid_modes = { 'i', 'n' },
				-- linewise_hybrid_mode = true,

				raw_previews = {
					-- This will cause only table's to show
					-- up as raw markdown in hybrid mode.
					markdown = { "tables", "!code_blocks", "images" },
				}

			},
			markdown = {
				list_items = {
					shift_width = function(buffer, item)
						--- Reduces the `indent` by 1 level.
						---
						---         indent                      1
						--- ------------------------- = 1 ÷ --------- = new_indent
						--- indent * (1 / new_indent)       new_indent
						---
						local parent_indnet = math.max(1, item.indent - vim.bo[buffer].shiftwidth);

						return (item.indent) * (1 / (parent_indnet * 2));
					end,
					marker_minus = {
						add_padding = function(_, item)
							return item.indent > 1;
						end
					}
				},
				headings = {
					enable = true,
					shift_width = 0,

					heading_1 = {
						style = 'label',
						sign = '󰌕 ',
						sign_hl = 'MarkviewHeading1Sign',

						padding_left = ' ',
						padding_right = ' ',
						corner_right = '',
						corner_right_hl = 'MarkviewHeading1Sign',
						icon = '󰼏  ',
						hl = 'MarkviewHeading1',
					},
					heading_2 = {
						style = 'label',
						sign = '󰌖 ',
						sign_hl = 'MarkviewHeading2Sign',

						padding_left = ' ',
						padding_right = ' ',
						corner_right = '',
						corner_right_hl = 'MarkviewHeading2Sign',
						icon = '󰎨  ',
						hl = 'MarkviewHeading2',
					},
					heading_3 = {
						style = 'label',

						padding_left = ' ',
						padding_right = ' ',
						corner_right = '',
						corner_right_hl = 'MarkviewHeading3Sign',
						icon = '󰼑  ',
						hl = 'MarkviewHeading3',
					},
					heading_4 = {
						style = 'label',

						padding_left = ' ',
						padding_right = ' ',
						corner_right = '',
						corner_right_hl = 'MarkviewHeading4Sign',
						icon = '󰎲  ',
						hl = 'MarkviewHeading4',
					},
					heading_5 = {
						style = 'label',

						padding_left = ' ',
						padding_right = ' ',
						corner_right = '',
						corner_right_hl = 'MarkviewHeading5Sign',
						icon = '󰼓  ',
						hl = 'MarkviewHeading5',
					},
					heading_6 = {
						style = 'label',

						padding_left = ' ',
						padding_right = ' ',
						corner_right = '',
						corner_right_hl = 'MarkviewHeading6Sign',
						icon = '󰎴  ',
						hl = 'MarkviewHeading6',
					},
				},
				tables = {
					block_decorator = false,
					strict = true
				},
				-- tables = presets.none,
				checkboxes = {
					checked = {
						text = '',
						hl = 'MarkviewCheckboxChecked',
						scope_hl = 'MarkviewCheckboxStriked',
					},
					unchecked = {
						text = '',
						hl = 'MarkviewCheckboxUnchecked',
					},
					custom = {
						{
							match_string = '-',
							text = '',
							hl = 'MarkviewCheckboxPending',
						},
						{
							match_string = '~',
							text = '',
							hl = 'MarkviewCheckboxProgress',
						},
						{
							match_string = 'o',
							text = '',
							hl = 'MarkviewCheckboxCancelled',
						},
						{
							match_string = '?',
							text = '󰋗',
							hl = 'MarkviewCheckboxPending',
						},
						{
							match_string = '!',
							text = '󰀦',
							hl = 'MarkviewCheckboxUnchecked',
						},
						{
							match_string = '*',
							text = '󰓎',
							hl = 'MarkviewCheckboxPending',
						},
						{
							match_string = '"',
							text = '󰸥',
							hl = 'MarkviewCheckboxCancelled',
						},
						{
							match_string = 'l',
							text = '󰆋',
							hl = 'MarkviewCheckboxProgress',
						},
						{
							match_string = 'b',
							text = '󰃀',
							hl = 'MarkviewCheckboxProgress',
						},
						{
							match_string = 'i',
							text = '󰰄',
							hl = 'MarkviewCheckboxChecked',
						},
						{
							match_string = 'S',
							text = '',
							hl = 'MarkviewCheckboxChecked',
						},
						{
							match_string = 'I',
							text = '󰛨',
							hl = 'MarkviewCheckboxPending',
						},
						{
							match_string = 'p',
							text = '',
							hl = 'MarkviewCheckboxChecked',
						},
						{
							match_string = 'c',
							text = '',
							hl = 'MarkviewCheckboxUnchecked',
						},
						{
							match_string = 'f',
							text = '󱠇',
							hl = 'MarkviewCheckboxUnchecked',
						},
						{
							match_string = 'k',
							text = '',
							hl = 'MarkviewCheckboxPending',
						},
						{
							match_string = 'w',
							text = '',
							hl = 'MarkviewCheckboxProgress',
						},
						{
							match_string = 'u',
							text = '󰔵',
							hl = 'MarkviewCheckboxChecked',
						},
						{
							match_string = 'd',
							text = '󰔳',
							hl = 'MarkviewCheckboxUnchecked',
						},
					},
				},
			}
		}
	end,
}
