return {
  {
    -- Autoformat, replaces mfussenegger/nvim-lint
    'stevearc/conform.nvim',
    -- version = 'v9.x', -- missing `rumdl`, pin using commit
    commit = '619363c30309d29ffa631e67c8183f2a72caa373',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        '<leader>cfF',
        function ()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer [Conform+LSP fallback]'
      },
      {
        '<leader>cff',
        function ()
          require('conform').format { async = true, lsp_fallback = false }
        end,
        mode = '',
        desc = '[F]ormat buffer [Conform]'
      },
      {
        '<leader>cfi',
        ':ConformInfo<CR>}',
        mode = '',
        desc = '[F]ormat buffer [ConformInfo]'
      },
      {
        '<leader>cft',
        '<cmd>FormatToggle<cr>',
        desc = 'Toggle autoformat'
      }
    },
    init = function ()
      vim.api.nvim_create_user_command(
        'FormatToggle',
        function (args)
          local is_global = not args.bang
          if is_global then
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            if vim.g.disable_autoformat then
              vim.notify('Autoformat-on-save disabled globally', 'info', { title = 'conform.nvim' })
            else
              vim.notify('Autoformat-on-save enabled globally', 'info', { title = 'conform.nvim' })
            end
          else
            vim.b.disable_autoformat = not vim.b.disable_autoformat
            if vim.b.disable_autoformat then
              vim.notify('Autoformat-on-save disabled globally for this buffer', 'info', { title = 'conform.nvim' })
            else
              vim.notify('Autoformat-on-save enabled globally for this buffer', 'info', { title = 'conform.nvim' })
            end
          end
        end,
        {
          desc = 'Toggle autoformat-on-save',
          bang = true
        }
      )
    end,
    opts = {
      -- If this is set, Conform will run the formatter on save.
      format_on_save = function (bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      -- log_level = vim.log.levels.DEBUG,
      notify_on_error = true,
      formatters_by_ft = {
        css = { 'prettier' },
        go = { 'goimports', 'gofumpt' },
        html = { 'prettier' },
        -- kdl = { 'kdlfmt' }, -- brakes niri :/
        javascriptreact = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        -- lua = { 'stylua' }, -- replaced by emmylua_ls
        -- markdown = { 'markdownlint-cli2' },               -- replaced by rumdl LSP
        markdown = { 'rumdl' },
        sh = { 'shfmt' },
        -- yamlfmt removes spaces around '{}' brakes ansible/kubernetes
        -- https://github.com/google/yamlfmt/issues/184
        yaml = { 'yamlfmt', 'trim_newlines', 'trim_whitespace' }, -- ~/.config/yamlfmt/yamlfmt.yml
        ['yaml.ansible'] = { 'trim_newlines', 'trim_whitespace' } -- ~/.config/yamlfmt/yamlfmt.yml
      },
      formatters = {
        rumdl = {
          cmd = 'rumdl',
          args = { 'fmt', '--silent', '-' }
        },
        -- yamlfmt doesn't care about `excludes` in config when used by conform
        -- data is passed as stdin, so it doesn't know about paths
        yamlfmt = {
          condition = function (self, ctx)
            return not ctx.filename:match("etc/authelia/oidc%.yml$")
          end
        }
      }
    }
  }
}
-- vim: ts=2 sts=2 sw=2 et
