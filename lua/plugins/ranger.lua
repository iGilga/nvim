return {
  'kelly-lin/ranger.nvim',
  keys = {
    { '<c-t>', "<cmd>lua require('ranger-nvim').open(true)<cr>" },
  },
  config = function()
    require('ranger-nvim').setup({ replace_netrw = true })
  end,
}
