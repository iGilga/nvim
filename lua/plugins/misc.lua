return {
  -- { 'nvim-lua/plenary.nvim' },
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
    'chentoast/marks.nvim',
  },
  {
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    config = function()
      require('illuminate').configure({
        providers = {
          'lsp',
          -- 'treesitter'
        },
        filetype_denylist = {
          'NvimTree',
          'lazy',
          'norg',
          'toggleterm',
          'TelescopePrompt',
        },
        under_cursor = false,
      })
    end,
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
    ft = 'norg',
    config = function()
      require('neorg').setup({
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
      })
    end,
    dependencies = 'nvim-lua/plenary.nvim',
  },
  {
    'gennaro-tedesco/nvim-jqx',
    ft = { 'json', 'yaml' },
    config = true,
    -- config = function()
    --   require('nvim-jqx.config').use_quickfix = false
    -- end,
    -- JqxList
    -- JqxQuery
  },
}
