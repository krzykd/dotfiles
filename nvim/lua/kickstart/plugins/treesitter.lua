local ensureInstalled = {
  'awk',
  'bash',
  'c',
  'css',
  'csv',
  'diff',
  'dockerfile',
  'fish',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'gosum',
  'gotmpl',
  'html',
  'ini',
  'jinja',
  'jinja_inline',
  'jq',
  'json',
  'just',
  'kdl',
  'kitty',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'nginx',
  'perl',
  'php',
  'puppet',
  'python',
  'regex',
  'rst',
  'sql',
  'ssh_config',
  'terraform',
  'toml',
  'typescript',
  'typst',
  'xml',
  'udev',
  'vim',
  'vimdoc',
  'yaml',
  'zsh',
}
return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    dependencies = {
      "OXY2DEV/markview.nvim", -- markview needs to be loaded before treesitter
    },
    -- event = { 'BufReadPre', 'BufNewFile' },
    lazy = false,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    build = ':TSUpdate',
    -- https://www.qu8n.com/posts/treesitter-migration-guide-for-nvim-0-12
    init = function()

    end,
    config = function(_, opts)
      local alreadyInstalled = require('nvim-treesitter.config').get_installed()
      local parsersToInstall = vim.iter(ensureInstalled)
          :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
          end)
          :totable()
      -- Install file type parsers
      require('nvim-treesitter').install(parsersToInstall)


      -- Autostart
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          -- highlighting
          pcall(vim.treesitter.start)

          -- Folds
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"

          -- Indentation
          vim.bo[args.buf].indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
        end,
      })

      -- incremental selection treesitter/lsp
      vim.keymap.set({ "n", "x", "o" }, "<A-o>", function()
        if vim.treesitter.get_parser(nil, nil, { error = false }) then
          require("vim.treesitter._select").select_parent(vim.v.count1)
        else
          vim.lsp.buf.selection_range(vim.v.count1)
        end
      end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

      vim.keymap.set({ "n", "x", "o" }, "<A-i>", function()
        if vim.treesitter.get_parser(nil, nil, { error = false }) then
          require("vim.treesitter._select").select_child(vim.v.count1)
        else
          vim.lsp.buf.selection_range(-vim.v.count1)
        end
      end, { desc = "Select child treesitter node or inner incremental lsp selections" })

      -- additional_vim_regex_highlighting replacement
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'ruby', 'markdown' },
        callback = function() vim.bo.syntax = vim.bo.filetype end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    -- ft = 'markdown', -- Lazy load on markdown filetype
    opts = {
      mode = 'cursor',
      max_lines = 3,
      separator = ' ',
    },
  },

  {
    -- Needed as dependency for mini.ai so af/if(around function/inner function) motion work correctly
    -- https://github.com/echasnovski/mini.nvim/issues/947 [mini.ai] No textobject "af"/"if" found
    -- Open golang file and check if golang textobjects.scm is loaded
    -- `:lua print(vim.inspect(vim.treesitter.query.get_files('go', 'textobjects')))`
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true

      -- Or, disable per filetype (add as you like)
      -- vim.g.no_python_maps = true
      -- vim.g.no_ruby_maps = true
      -- vim.g.no_rust_maps = true
      -- vim.g.no_go_maps = true
    end,
    config = function()
      -- put your config here
    end,
  },

}
-- vim: ts=2 sts=2 sw=2 et
