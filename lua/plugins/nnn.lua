-- file manager
local keys = {
  { 't', '<c-t>', '<cmd>:NnnPicker<cr>', desc = 'open nnn' },
  { 'n', '<c-t>', '<cmd>:NnnPicker<cr>', desc = 'open nnn' },
}
return {
  'luukvbaal/nnn.nvim',
  cmd = 'NnnPicker',
  keys = keys,
  config = {
    explorer = { session = 'shared' },
    picker = {
      session = 'shared',
      style = { border = 'solid' },
    },
  },
}
