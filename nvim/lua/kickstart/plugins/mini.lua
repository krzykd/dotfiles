-- local spec_treesitter = require('mini.ai').gen_spec.treesitter
return {
  {
    'nvim-mini/mini.icons',
    tag = 'v0.16.0',
    recommended = true,
    lazy = true,
    opts = {},
  },
  {
    'nvim-mini/mini.surround',
    tag = 'v0.16.0',
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    keys = function(plugin, keys)
      local mappings = {
        { plugin.opts.mappings.add,            desc = "Add Surrounding",                     mode = { "n", "x" } },
        { plugin.opts.mappings.delete,         desc = "Delete Surrounding" },
        { plugin.opts.mappings.find,           desc = "Find Right Surrounding" },
        { plugin.opts.mappings.find_left,      desc = "Find Left Surrounding" },
        { plugin.opts.mappings.highlight,      desc = "Highlight Surrounding" },
        { plugin.opts.mappings.replace,        desc = "Replace Surrounding" },
        { plugin.opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,

    recommended = true,
    opts = {
      highlight_duration = 500,
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    'nvim-mini/mini.ai',
    tag = 'v0.16.0',
    -- event = 'VeryLazy',
    event = { 'BufReadPre', 'BufNewFile' },
    -- NOTE: Needs nvim-treesitter/nvim-treesitter-textobjects
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- html tags
          d = { "%f[%d]%d+" },                                                -- digits
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
