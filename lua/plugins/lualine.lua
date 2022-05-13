local lualine = require('lualine')

local function getSessionName()
  if vim.v.this_session then
    local session = vim.v.this_session
    local splitSessionPath = vim.split(session, '%%')
    local sessionName = splitSessionPath[#splitSessionPath]:gsub('%.vim', '')
    if sessionName == nil or sessionName == '' then
      return '[No Session]'
    end
    return '[S]' .. sessionName
  end
end

local custom_kanagawa = require('lualine.themes.kanagawa')
custom_kanagawa.normal.c = { bg = "#2A2A37", fg = "#C8C093" }

local config = {
  options = {
    theme = custom_kanagawa,
    icons_enabled = true,
    disabled_filetypes = { 'NnnExplorer', 'NnnPicker', 'packer', 'NVimTree' },
    globalstatus = true,
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { {
      'mode',
      fmt = function(str)
        return str:sub(1, 1)
      end,
    } },
    lualine_b = { { getSessionName }, { 'filename', file_status = true } },
    lualine_c = { { 'diagnostics', sources = { 'nvim_diagnostic' } } },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { { 'branch', icon = '', 'diff' } },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { 'quickfix', 'fzf' },
}

lualine.setup(config)
