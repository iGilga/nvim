-- file manager
return {
  'luukvbaal/nnn.nvim',
  cmd = 'NnnPicker',
  config = {
    explorer = { session = 'shared' },
    picker = {
      session = 'shared',
      style = { border = 'solid' },
    },
  },
}
