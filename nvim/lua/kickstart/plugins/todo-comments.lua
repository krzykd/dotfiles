-- Highlight todo, notes, etc in comments
-- INFO:
-- NOTE:
-- WARN:
-- TODO:
-- BUG:
-- HACK:
-- PERF:
return {
  {
    'folke/todo-comments.nvim',
    -- event = 'VeryLazy',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    version = 'v1.5.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      ---@diagnostic disable-next-line: undefined-field
      {
        "<leader>st",
        function ()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo"
      },
      ---@diagnostic disable-next-line: undefined-field
      {
        "<leader>sT",
        function ()
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme"
      }
    },
    opts = {
      keywords = {
        NOTE = { icon = ' ', color = 'note', alt = { "NOTE" } },
        INFO = { icon = ' ', color = 'hint', alt = { "INFO", "DOCS" } }
        -- NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } }
      },
      -- Use markdown comments for TODO highlighting `<!-- -->` ie `<!-- TODO: foooo -->`
			-- https://github.com/folke/todo-comments.nvim/issues/150#issuecomment-1306826575
			-- https://github.com/folke/todo-comments.nvim/issues/264
			-- https://github.com/folke/todo-comments.nvim/issues/283
			-- highlight = { comments_only = false },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        note = { "#00BAEF", "#00BAEF" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      }
    }
  }
}
