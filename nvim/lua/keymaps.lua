-- See `:help vim.keymap.set()`
local map = vim.keymap.set
local unmap = vim.keymap.del

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function ()
    vim.highlight.on_yank()
  end
})

-- Clear highlight on pressing <Esc> in normal mode
map('n', '<Esc>', '<CMD>nohlsearch<CR>')

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<CMD>echo "Use h to move!!"<CR>')
map('n', '<right>', '<CMD>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<CMD>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<CMD>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move Lines with Alt in NORMAL/INSERT/VISUAL
map('n', '<A-j>', '<CMD>m .+1<cr>==', { desc = 'Move Down' })
map('n', '<A-k>', '<CMD>m .-2<cr>==', { desc = 'Move Up' })
map('i', '<A-j>', '<esc><CMD>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc><CMD>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', "<CMD>m '>+1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', "<CMD>m '<-2<cr>gv=gv", { desc = 'Move Up' })
-- Move Lines with Shift
map('v', 'J', "<CMD>m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = 'move highlighted text down' })
map('v', 'K', "<CMD>m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = 'move highlighted text up' })

-- thx primeagen
map('x', '<leader>p', [["_dP]], { desc = 'Paste without overwriting buffer' })
map('n', 'J', 'mzJ`z', { desc = 'Join lines, but cursor stays where it was' })
-- map('n', '<C-d>', '<C-d>zz', { desc = 'Down Half Page' })
-- map('n', '<C-u>', '<C-u>zz', { desc = 'Up Half Page' })
-- map('n', '<leader>C', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'change/substitute hovered word' })

-- quick home/end in NORMAL
map('n', 'H', '^', { desc = 'Go to beginin of the line' })
map('n', 'L', '$', { desc = 'Go to the end of the line' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- The direction of n and N depends on whether / or ? was used for searching forward or backward respectively.
-- If you want n to always search forward and N backward, use this:
map('n', 'n', "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = 'Next Search Result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zzzv'", { expr = true, desc = 'Prev Search Result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- lazy
map('n', '<leader>L', '<CMD>Lazy<cr>', { desc = 'which_key_ignore' })

-- new file
map('n', '<leader>nf', '<CMD>enew<cr>', { desc = 'New [F]ile' })

-- buffers
map('n', '<tab>', '<CMD>bnext<cr>', { desc = 'Next buffer' })
map('n', '<s-tab>', '<CMD>bprevious<cr>', { desc = 'Previous buffer' })
map('n', '<leader>qx', '<CMD>:lua Snacks.bufdelete()<CR>', { desc = 'Close buffer' })
map('n', '<C-w><C-w>', '<CMD>:lua Snacks.bufdelete()<CR>', { desc = 'Close buffer' })
map('n', '<leader>qX', '<CMD>:lua Snacks.bufdelete.all()<CR>', { desc = 'Close All buffers' })

-- keywordprg
map('n', '<leader>K', '<CMD>norm! K<cr>', { desc = 'Keywordprg' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- save file when in INSERT/VISUAL/NORMAL/SELECT
map({ 'i', 'n', 'x', 's' }, '<C-s>', '<CMD>w<cr><esc>', { desc = 'Save File' })

-- quit
map('n', '<leader>qc', '<CMD>close<cr>', { desc = 'Close window' })
map('n', '<leader>qq', '<CMD>q<cr>', { desc = 'Quit' })
map('n', '<leader>qQ', '<CMD>q!<cr>', { desc = 'Quit!' })
map('n', '<leader>qa', '<CMD>qa<cr>', { desc = 'Quit All' })
map('n', '<leader>qA', '<CMD>qa!<cr>', { desc = 'Quit All!' })
map('n', '<leader>qs', '<CMD>xa<cr>', { desc = 'Quit All (save)' })

-- splits
map('n', '<Leader>\\', '<CMD>vsplit<CR>', { desc = 'which_key_ignore' }) -- Vertical split
map('n', '<Leader>|', '<CMD>botright vsplit<CR>', { desc = 'which_key_ignore' }) -- Bottom split
map('n', '<Leader>-', '<CMD>split<CR>', { desc = 'which_key_ignore' }) -- Horizontal split
map('n', '<Leader>_', '<CMD>botright split<CR>', { desc = 'which_key_ignore' }) -- Right split

-- telescope dependent plugins
map('n', '<leader>f.', '<CMD>cd %:h<CR>', { desc = 'Change Working Directory' })

-- selfexplanatory
map('n', '<c-z>', '', { desc = 'Disable suspend with Ctrl+z' })
-- map('n', ';', ':', { desc = 'CMD enter command mode' }) -- used by otavioschwanck/arrow.nvim
-- map('n', '<Leader>o', 'o<ESC>', { desc = 'Insert newline above and return to NORMAL' })
-- map('n', '<Leader>O', 'O<ESC>', { desc = 'Insert newline below and return to NORMAL' })
map('i', '<C-BS>', '<Esc>cvb', { desc = 'Delete entire word' })
map('n', '<C-g>', '1<C-g>', { desc = 'Show full path' }) -- instead of shortened/relative path. Default 0<C-g> == `:file`

-- Diagnostic keymaps
-- global lsp mappings
local diagnostic_goto = function (next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function ()
    go { severity = severity }
  end
end
map('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [D]iagnostic message' })
map('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'lsp floating diagnostics' })
map('n', '<leader>li', '<CMD>checkhealth vim.lsp<CR>', { desc = '[L]sp[I]nfo' })
-- map('n', '<leader>li', '<CMD>LspInfo<CR>', { desc = '[L]sp[I]nfo' })
map('n', '<leader>ln', '<CMD>NullLsInfo<CR>', { desc = '[N]ullLs[I]nfo' })

-- Copy
map('n', '<C-S-a>', '<CMD>%y+<CR>', { desc = 'file copy whole' })
map('n', '<leader>cC', '<CMD>%y+<CR>', { desc = '[c]opy whole file' })
-- map('v', '<leader>cc', '<CMD>"y+<CR>', { desc = 'copy selection' })

-- Macros, disable standard keymap
map('n', 'q', '<nop>', { noremap = true })
map('n', '<C-q>', 'q', { noremap = false })

-------------------------------------------------------------------------------
--                         Start CMDline-window section
-------------------------------------------------------------------------------
-- https://www.reddit.com/r/neovim/comments/lizyxj/how_to_get_rid_of_q/
-- https://www.reddit.com/r/neovim/comments/15bvtr4/comment/jtszt8u/
map('n', 'q:', '<nop>') -- this only disables 'q:' if both keys are pressed without delay
map('n', 'q?', '<nop>')
map('n', 'q/', '<nop>')

local function escape(keys)
  return vim.api.nvim_replace_termcodes(keys, true, false, true)
end

-- Use <C-h>, to emulate <C-f> (which is used by kitty)
map('c', '<C-h>', function ()
  vim.g.requested_CMDwin = true
  vim.api.nvim_feedkeys(escape '<C-f>', 'n', false)
end)

-- Disable 'q' ... long delay ... ':'
-- screen will flash, because command-line-window is opened but it's closed instantenously
vim.api.nvim_create_autocmd('CmdWinEnter', {
  group = vim.api.nvim_create_augroup('CWE', { clear = true }),
  pattern = '*',
  callback = function ()
    if vim.g.requested_CMDwin then
      vim.g.requested_CMDwin = nil
    else
      vim.api.nvim_feedkeys(escape ':q<CR>:', 'm', false)
    end
  end
})
-------------------------------------------------------------------------------
--                         End CMDline-window section
----------------------------------------------------------------------------------

map('n', '<leader>tn', '<CMD>tabnew<CR>', { desc = 'New tab' })
map('n', '<leader>tc', '<CMD>tabclose<CR>', { desc = 'Close tab' })
map('x', '<leader>p', [["_dP]], { desc = 'Paste without overwriting buffer' })

-- vim: ts=2 sts=2 sw=2 et
