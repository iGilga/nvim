local config = require('config.user')

local signs = {
  Error = '󰅚',
  Warn = '󰀪',
  Hint = '󰌶',
  Info = '󰋽',
}

if vim.fn.has("nvim-0.9.0") == 1 then
  print('DiagnosticSign')
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end
end

vim.diagnostic.config({
  update_in_instert = true,
  severity_sort = true,
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Info,
    }
  },
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
