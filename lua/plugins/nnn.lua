-- file manager
local keys = {
  {  '<c-t>', '<cmd>:NnnPicker<cr>', desc = 'open nnn', mode = 't' },
  {  '<c-t>', '<cmd>:NnnPicker<cr>', desc = 'open nnn' },
}
return {
  'luukvbaal/nnn.nvim',
  cmd = 'NnnPicker',
  keys = keys,
  opts = {
    explorer = { session = 'shared' },
    picker = {
      session = 'shared',
      style = { border = 'solid' },
    },
  },
}
