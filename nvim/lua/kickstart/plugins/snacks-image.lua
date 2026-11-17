return {
	"alteriks/snacks.nvim",
	---@type snacks.Config
	opts = {
		image = {
			convert = {
				d2_opts = {
					layout = "elk"
				}
			}
			-- your image configuration comes here
			-- or leave it empty to use the default settings
		},
		scroll = {
			-- your scroll configuration comes here
			-- or leave it empty to use the default settings
		}
	}
	-- config = function(_, opts)
	-- config = function()
	-- 	require("snacks").setup {
	-- 		image = {
	-- 			-- Support images in obsidian
	-- 			resolve = function(path, src)
	-- 				if require("obsidian.api").path_is_note(path) then
	-- 					return require("obsidian.api").resolve_image_path(src)
	-- 				end
	-- 			end,
	-- 		},
	-- 	}
	-- end
}
