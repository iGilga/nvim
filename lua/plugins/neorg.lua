return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  cmd = 'Neorg',
  keys = {
    { '<leader>n',  '<cmd>:Neorg<cr>',        desc = '[Neorg]Open menu' },
    { '<leader>nc', '<cmd>:Neorg return<cr>', desc = '[Neorg]Close neorg' },
  },
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.export'] = {},
      ['core.export.markdown'] = {},
      ['core.completion'] = { config = { engine = 'nvim-cmp' } },
      ['core.concealer'] = {},
      ['core.qol.todo_items'] = {
        config = {
          create_todo_parents = true,
        },
      },
      ['core.dirman'] = {
        config = {
          default_workspace = 'coding',
          workspaces = {
            coding = '~/notes/codiing',
            home = '~/notes/home',
          },
        },
      },
      ['core.integrations.telescope'] = {},
    },
  },
  dependencies = { { 'nvim-lua/plenary.nvim' }, 'nvim-neorg/neorg-telescope' },
}
