return {
  -- { 'nvim-lua/plenary.nvim' },
  { 'MunifTanjim/nui.nvim' },
  {
    'chentoast/marks.nvim',
    lazy = false,
    config = true,
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
    'gennaro-tedesco/nvim-jqx',
    ft = { 'json', 'yaml' },
    -- config = function()
    --   require('nvim-jqx.config').use_quickfix = false
    -- end,
    -- JqxList
    -- JqxQuery
  },
  {
    'nacro90/numb.nvim',
    lazy = false,
    config = true,
  },
}
