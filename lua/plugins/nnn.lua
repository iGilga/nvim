-- file manager
return {
  'luukvbaal/nnn.nvim',
  cmd = 'NnnPicker',
  config = {
    explorer = { session = 'local' },
    picker = {
      session = 'local',
      style = { border = 'solid' },
    },
  },
}
