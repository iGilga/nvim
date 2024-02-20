local keys = function()
  local oil = require('oil')
  return
  {
    { '<leader>m',  oil.open,  desc = 'open oil', },
    { '<leader>mc', oil.close, desc = 'close oil', },
  }
end
return {
  'stevearc/oil.nvim',
  keys = keys,
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
