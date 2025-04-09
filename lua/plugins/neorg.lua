return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  config = true,
  keys = {
    { '<leader>n', '<cmd>:Neorg<cr>', desc = '[Neorg]Open menu' },
    { '<leader>nc', '<cmd>:Neorg return<cr>', desc = '[Neorg]Close neorg' },
  },
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.qol.todo_items'] = {
        config = {
          create_todo_parents = true,
        },
      },
      ['core.concealer'] = {
        config = {
          icons = {
            code_block = {
              conceal = true,
            },
          },
        },
      },
      ['core.dirman'] = {
        config = {
          default_workspace = 'code',
          workspaces = {
            code = '~/notes/code',
            home = '~/notes/home',
          },
        },
      },
      ['core.export'] = {},
      ['core.export.markdown'] = {},
      ['core.integrations.telescope'] = {},
    },
  },
  dependencies = { { 'nvim-lua/plenary.nvim' }, 'nvim-neorg/neorg-telescope' },
}
