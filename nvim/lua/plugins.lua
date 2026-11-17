return {

  { -- show a diff, whenever recovering a buffer
    'chrisbra/Recover.vim',
    -- Use :RecoverPluginFinish, to  delete the no-longer-needed swap file when in the recovered window,
    -- this will delete the swapfile, close the diff window, and end the diff/merge process.
  },

  -- NOTE: All plugins here should be pinned
  -- verify in snacks grep using '\b(version|tag|commit) ='
  require 'kickstart/plugins/colorizer',
  -- require 'kickstart/plugins/flash',
  require 'kickstart/plugins/mini',
  require 'kickstart/plugins/todo-comments',
  require 'kickstart/plugins/undo',
  require 'kickstart/plugins/which-key',
  require 'kickstart/plugins/snacks',
  require 'kickstart/plugins/snacks-picker',
  require 'kickstart/plugins/snacks-explorer',
  require 'kickstart/plugins/suda',

  -- require 'kickstart/plugins/deprecated',
}

-- vim: ts=2 sts=2 sw=2 et
