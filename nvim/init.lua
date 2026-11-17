--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Set generic neovim options ]]
require 'options'

-- [[ Load generic autocommands ]]
require 'autocmd'

-- [[ Install `lazy.nvim` plugin manager ]]
-- [[ Also configure and install plugins ]]
require 'lazy-bootstrap'

-- [[ Basic Keymaps ]]
-- Many plugins have their own way of configuring key mappings
require 'keymaps'

-- vim: ts=2 sts=2 sw=2 et
