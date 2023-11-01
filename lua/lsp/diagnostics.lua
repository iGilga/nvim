local config = require('config.user')

local signs = {
  Error = '󰅚',
  Warn = '󰀪',
  Hint = '󰌶',
  Info = '󰋽',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.diagnostic.config({
  update_in_instert = true,
  severity_sort = true,
  underline = true,
  signs = true,
  float = {
    border = config.border,
    -- focusable = false,
    source = 'always',
  },
  virtual_text = {
    spacing = 1,
    prefix = '󰝤',
  },
})
