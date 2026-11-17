local version = require("vim.version")
if vim.env.KITTY_SCROLLBACK_NVIM == 'true' then
	-- print 'NOT loading ide'
	return {}
end
if not (vim.fn.hostname() == 'carbon' or vim.fn.hostname() == 'moar') then
	-- This check needs to be on top, so we return {}, before parsing `ide` and `image`
	-- print 'NOT loading ide'
	return {}
end
local ide = {

	require 'kickstart/plugins/autopairs',      -- Use fast wrap <c-e> after initial `"'([{ to complete `"')]}
	require 'kickstart/plugins/arrow',
	require 'kickstart/plugins/chezmoi',
	require 'kickstart/plugins/database',
	require 'kickstart/plugins/dial',
	require 'kickstart/plugins/grug-far',
	require 'kickstart/plugins/kulala',         -- http client
	require 'kickstart/plugins/img-clip',
	require 'kickstart/plugins/kitty-scrollback',
	require 'kickstart/plugins/persistence',
	require 'kickstart/plugins/rsync',
	require 'kickstart/plugins/snacks-scratch', -- NOTE: learn
	require 'kickstart/plugins/sops',
	require 'kickstart/plugins/toggleterm',

	-- UI
	require 'ui/plugins/buffers',
	require 'ui/plugins/colorful-winsep',
	require 'ui/plugins/dropbar',
	require 'ui/plugins/dashboard-snacks',
	require 'ui/plugins/notify',
	require 'ui/plugins/smart-paste',
	require 'ui/plugins/zen',
	require 'ui/plugins/pathfinder',
	require 'kickstart/plugins/trouble',
	require 'kickstart/plugins/ufo',
	require 'kickstart/plugins/indent_line',

	-- LANG
	require 'kickstart/syntax',
	require 'kickstart/plugins/markview',
	require 'kickstart/plugins/markdown',
	require 'kickstart/plugins/conform',
	require 'kickstart/plugins/treesitter',
	require 'kickstart/plugins/lazydev',
	require 'kickstart/plugins/schemastore',
	-- require 'kickstart/plugins/debug', -- TODO:
	-- require 'kickstart/plugins/orgmode',

	-- LSP+Completion+LuaSnip
	require 'kickstart/plugins/blink-cmp',
	require 'kickstart/plugins/lsp',
	-- require 'kickstart/plugins/none-ls',

	-- GIT
	require 'kickstart/plugins/diffview',
	require 'kickstart/plugins/neogit',
	require 'kickstart/plugins/gitsigns',

	require 'options-experimental'
}

local image = { require 'kickstart/plugins/snacks-image' }

-- append ide to image
vim.list_extend(image, ide)

if vim.fn.hostname() == 'carbon' or vim.fn.hostname() == 'moar' then
	if vim.g.neovide then
		-- print 'loading ide'
		return ide
	else
		return image
	end
else
	-- print 'NOT loading ide'
	return {}
end
