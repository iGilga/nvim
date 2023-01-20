return {
  { 'nvim-lua/plenary.nvim' },
  { 'MunifTanjim/nui.nvim' },
  -- {
  --   'antoinemadec/FixCursorHold.nvim',
  --   event = { 'BufRead', 'BufNewFile' },
  --   config = function()
  --     vim.g.cursorhold_updatetime = 100
  --   end,
  -- },

  -- find project for telescope
  -- {
  --   'ahmedkhalf/project.nvim',
  --   config = function()
  --     require('project_nvim').setup({})
  --   end,
  -- },
  {
    'yamatsum/nvim-cursorline',
    enabled = false,
  },
  {
    'max397574/better-escape.nvim',
    config = true,
  },
  {
    'sQVe/sort.nvim',
    cmd = 'Sort',
    config = function()
      require('sort').setup({})
    end,
  },
  {
    'nvim-neorg/neorg',
    config = function()
      require('neorg').setup({
        ['core.defaults'] = {},
        ['core.norg.dirman'] = {
          config = {
            workspaces = {
              work = '~/notes/work',
              home = '~/notes/home',
            },
          },
        },
      })
    end,
    dependencies = 'nvim-lua/plenary.nvim',
  },
}
