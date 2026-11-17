-- https://github.com/HakonHarnes/img-clip.nvim
-- Effortlessly embed images into any markup language, like LaTeX, Markdown or Typst.
-- Seamlessly drag and drop images from your web browser or file explorer
-- Automatically download and embed images from the web

return {
	'HakonHarnes/img-clip.nvim',
	version = 'v0.6.0',
	ft = 'markdown',
	opts = {
		default = {
			dir_path = 'media',
			relative_to_current_file = true,
			prompt_for_file_name = false,
			file_name = function()
				local file_name = vim.fn.expand '%:t:r'
				local timestamp = os.date '%Y-%m-%d-%H-%M-%S'
				return file_name .. '-' .. timestamp
			end,
			-- INFO: drag&drop slows pasting URLS
			-- Pasting with middle click works OK
			-- slowed down <c-s-v> of urls #85 https://github.com/HakonHarnes/img-clip.nvim/issues/85
			-- drag_and_drop = {
			-- 	insert_mode = true,
			-- },
		},
		filetypes = {
			markdown = {
				download_images = true,
			},
		},
	},
	keys = {
		-- suggested keymap
		{ '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
	},
}
