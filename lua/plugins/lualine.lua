local function getSessionName()
  if vim.v.this_session ~= '' then
    local session = vim.v.this_session
    local splitSessionPath = vim.split(session, '__')
    local sessionName = splitSessionPath[#splitSessionPath]
    return '[' .. sessionName .. ']'
  else
    return ''
  end
end

local custom_theme = require('theme.lualine')

local setup = {
  options = {
    theme = custom_theme,
    icons_enabled = true,
    disabled_filetypes = { statusline = { 'help', 'TelescopePrompt', 'alpha' } },
    globalstatus = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { {
      'mode',
      fmt = function(str)
        return str:sub(1, 1)
      end,
    } },
    lualine_b = { { getSessionName }, { 'filename' } },
    lualine_c = {
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_x = {
      -- { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
      { 'diff', symbols = { added = '󰐖 ', modified = '󱗜 ', removed = '󰍵 ' } },
    },
    lualine_y = { { 'branch', icon = '' }, 'filetype' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { 'quickfix', 'fzf' },
}

return {
  'hoob3rt/lualine.nvim',
  lazy = false,
  priority = 500,
  opts = setup,
}
