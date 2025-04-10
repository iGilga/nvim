local handlers = require('lsp.handlers')

require('lsp.mapping')
require('lsp.diagnostics')

local lsp_list = {
  'lua_ls',
  'ts_ls',
  'eslint',
}

local capabilities = {}

local ok, blink = pcall(require, 'blink')
if ok then
  capabilities = blink.get_lsp_capabilities()
end

vim.lsp.config('*', {
  handlers = handlers,
  capabilities = capabilities,
})

vim.lsp.enable(lsp_list)
