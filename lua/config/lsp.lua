local handlers = require('lsp.handlers')

require('lsp.mapping')
require('lsp.diagnostics')

local lsp_list = {
  'lua_ls',
  'ts_ls',
  'eslint',
}

local capabilities = {}

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities()
end

local ok, blink = pcall(require, 'blink')
if ok then
  capabilities = blink.get_lsp_capabilities()
end

vim.lsp.config('*', {
  handlers = handlers,
  capabilities = capabilities,
})

vim.lsp.enable(lsp_list)
