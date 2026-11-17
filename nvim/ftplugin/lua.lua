local map = vim.keymap.set

-- Better gf, if file doesn't exist create it!
-- useful for `require`,`dofile`
map('n', 'gf', ':e lua/<cfile>.lua<cr>')
