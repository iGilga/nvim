local on_attach = require('lsp.mapping')

local lsp_list = {
  'lua_ls',
  'ts_ls',
  'eslint',
}

vim.lsp.config('*', {
  on_attach = on_attach,
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
vim.lsp.enable(lsp_list)
require('lsp.diagnostics')
