local setup = {
  disable = { filetype = { 'TelescopePromt', 'nvim-tree' } },
}
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<C-G>',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer local keymaps [which-key]'
    },
  },
  opts = setup,
}
