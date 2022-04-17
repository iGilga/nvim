local lualine = require('lualine')

local config = {
  options = {
    disabled_filetypes = { 'NnnExplorer', 'NnnPicker', 'packer', 'NVimTree' },
  },
  sections = {
    -- lualine_c = {
    -- },
    lualine_x = {
      { require('auto-session-library').current_session_name },
      'encoding',
      'fileformat',
      'filetype',
    },
  },
  extensions = { 'fzf' },
}

lualine.setup(config)
