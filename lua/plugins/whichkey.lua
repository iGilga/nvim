local setup = {
  disable = { filetype = { 'TelescopePromt', 'nvim-tree' } },
}
return {
  keys = {
    { '<F9>', '<cmd>WhichKey<cr>' },
  },
  'folke/which-key.nvim',
  config = setup,
}
