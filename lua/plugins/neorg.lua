return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.norg.completion'] = { config = { 'nvim-cmp' } },
      ['core.norg.concealer'] = {
        config = {
          icon_preset = 'varied',
          folds = false,
          dim_code_blocks = {
            enabled = true,
            padding = { left = 1 },
          },
        },
      },
      ['core.norg.dirman'] = {
        config = {
          workspaces = {
            work = '~/notes/work',
            home = '~/notes/home',
          },
        },
      },
    },
  },
  dependencies = { { 'nvim-lua/plenary.nvim' } },
}
