local keys = {
  {
    '<leader>m',
    function()
      require('oil').open()
    end,
    desc = 'open nvim-tree',
  },
  {
    '<leader>mc',
    function()
      require('oil').close()
    end,
    desc = 'open nvim-tree',
  },
}
return {
  'stevearc/oil.nvim',
  keys = keys,
  opts = {},
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
