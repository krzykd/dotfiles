-- NOTE: works only on 0.12
-- https://www.reddit.com/r/neovim/comments/1ov1gtr/difftool_wrapper/
vim.api.nvim_create_user_command('DirDiff', function (opts)
  if vim.tbl_count(opts.fargs) ~= 2 then
    vim.notify('DirDiff requires exactly two directory arguments', vim.log.levels.ERROR)
    return
  end

  vim.cmd 'tabnew'
  vim.cmd.packadd 'nvim.difftool'
  require('difftool').open(opts.fargs[1], opts.fargs[2], {
    rename = {
      detect = false
    },
    ignore = { '.git' }
  })
end, { complete = 'dir', nargs = '*' }
)

-- require "vim._core.ui2".enable {
--   enable = true, -- Whether to enable or disable the UI.
--   msg = {        -- Options related to the message module.
--     ---@type 'cmd'|'msg' Where to place regular messages, either in the
--     ---cmdline or in a separate ephemeral message window.
--     target = "msg",
--     timeout = 4000, -- Time a message is visible in the message window.
--   },
-- }

return {}
-- vim: ts=2 sts=2 sw=2 et
