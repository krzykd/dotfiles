-- [[ Setting options ]]
-- See `:help vim.opt`,  `:help option-list`

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Sync clipboard across SSH sessions
if vim.env.SSH_TTY then
	local osc52 = require('vim.ui.clipboard.osc52')
	vim.g.clipboard = {
		name = 'OSC 52',
		copy = { ['+'] = osc52.copy('+'), ['*'] = osc52.copy('*') },
		paste = { ['+'] = osc52.paste('+'), ['*'] = osc52.paste('*') }
	}
end

if vim.fn.hostname() == 'carbon' or vim.fn.hostname() == 'moar' then
	-- folds, configured by kevinhwang91/nvim-ufo
	vim.o.foldenable = true
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99
	vim.opt.foldcolumn = '1'
	-- Leftmost column which can displays git gutter,lsp error/warnings, etc
	vim.opt.signcolumn = 'yes'
	vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
else
	-- override defaults used by garage servers
	vim.opt.foldcolumn = '0' -- default used by garage servers. overriden in plugins-ide.lua
	-- default used by garage servers. overriden in plugins-ide.lua
	vim.opt.signcolumn = 'no'
end

-- Disable automatic commentstring when entering newline from NORMAL mode o/O OR enter in INSERT mode
-- :help fo-table
-- vim.api.nvim_create_autocmd('FileType', {
-- pattern = '*',
-- callback = function()
-- vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
-- end,
-- })

-- Always display status line on the bottom. Only display active window
vim.opt.laststatus = 3

-- Disable saving "blank,terminal" by folke/persistence
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize"

-- add minus sign, so we can search `for-some-params` when pressign */#
vim.o.iskeyword = '@,48-57,_,-,192-255'

-- Make line numbers default
vim.opt.number = true
-- Add relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Allow virtual editing in Visual block mode - the end is not the end!
vim.opt.virtualedit = 'block'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
-- vim.opt.breakindent = true

-- Insert indents automatically
vim.opt.smartindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 50

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- See `:help 'list'`
-- and `:help 'listchars'`
vim.opt.list = true

-- Preview substitutions live, as you type!
-- vim.opt.inccommand = 'split'

-- NOTE: use spaces not tabs everywhere!
-- We're overriding default `expandtab`
-- see ./ftplugin/yaml.ansible.lua
vim.opt_local.expandtab = true

-- Tab length
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.grepprg = 'rg --vimgrep'

-- Set highlight on search
vim.opt.hlsearch = true
-- to enable cursorline!
vim.opt.cursorlineopt = 'both'

vim.opt.commentstring = '# %s' -- default if filetype is not set and Comment.nvim cannot use computed LSP ts_context_commentstring

-- disable nvim intro
vim.opt.shortmess:append 'sI'

-- spell checking on specific filetypes
vim.opt.spelllang = { 'pl', 'en' }
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'html', 'markdown', 'text' },
	callback = function ()
		vim.opt_local.spell = true
	end
})

-- farmergreg/vim-lastplace replacement
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
	desc = 'return cursor to where it was last time closing the file',
	pattern = '*',
	command = 'silent! normal! g`"zv'
})

-- disable some default providers
vim.g['loaded_node_provider'] = 0
vim.g['loaded_python3_provider'] = 0
vim.g['loaded_perl_provider'] = 0
vim.g['loaded_ruby_provider'] = 0

-- INFO:bottomline is still needed! folke/noice most of the time notifications disappear to fast.
-- But sometimes they linger for too long if there are to many of them.
vim.opt.cmdheight = 1

-- Set border on all windows
if vim.fn.has('nvim-0.11') == 1 then
	vim.opt.winborder = "rounded"
end

-- INFO: helped solve snacks bug: No results found for `select`
-- ansiblels had trouble inside ~/git/acs directory because of old python venv,
-- without any deps (python couldn't import ansible module)
-- https://github.com/alteriks/snacks.nvim/discussions/2264
vim.schedule(function ()
	local orig_select = vim.ui.select
	vim.ui.select = function (items, opts, on_choice)
		local log_file = vim.fn.stdpath("cache") .. "/vim_ui_select_debug.log"
		local f = io.open(log_file, "a")
		if f then
			f:write(os.date("%Y-%m-%d %H:%M:%S") .. "\n")
			f:write("Items count: " .. (items and #items or "nil") .. "\n")
			f:write("Opts: " .. vim.inspect(opts or {}) .. "\n")
			if not items or #items == 0 then
				f:write("STACKTRACE:\n" .. debug.traceback() .. "\n")
			end
			f:write("---\n\n")
			f:close()
		end
		return orig_select(items, opts, on_choice)
	end
end)
