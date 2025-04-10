local handlers = require('lsp.handlers')

require('lsp.mapping')
require('lsp.diagnostics')

local lsp_list = {
  'lua_ls',
  'ts_ls',
  'eslint',
}

vim.lsp.config('*', {
  handlers = handlers,
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.enable(lsp_list)
