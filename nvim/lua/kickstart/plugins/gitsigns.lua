-- See `:help gitsigns`
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    commit = '20ad4419564d6e22b189f6738116b38871082332',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {

      {
        -- Used by plugins with '.' repeat
        -- ie lewis6991/gitsigns.nvim - ghs (Git Hunk Stage) can be repeated with '.'
        'tpope/vim-repeat',
        event = 'VeryLazy'
      }
    },
    opts = {
      -- debug_mode = true,
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' }
      },

      on_attach = function (bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function ()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Next git [h]unk change' }
        )

        map('n', '[h', function ()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Previous git [h]unk change' }
        )

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function ()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' }
        )
        map('v', '<leader>hr', function ()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' }
        )
        -- normal mode
        map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>ghb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>ghd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>ghD', function ()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' }
        )
        -- Toggles
        map('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git show [b]lame line' })
        map('n', '<leader>gD', gitsigns.toggle_deleted, { desc = 'Toggle git show [D]eleted' })
      end
    }
  }
}
-- vim: ts=2 sts=2 sw=2 et
