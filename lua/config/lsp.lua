local handlers = require('lsp.handlers')

require('lsp.mapping')
require('lsp.diagnostics')

local lsp_list = {
  'clangd',
  'cssls',
  'cssmodules_ls',
  -- 'dockerls',
  'emmet-language-server',
  'eslint',
  -- 'graphql',
  'jsonls',
  'lua_ls',
  -- 'tailwindcssls',
  -- 'ts_ls',
  'yamlls',
  'vtsls',
}

local capabilities = {}

local ok, blink = pcall(require, 'blink')
if ok then
  capabilities = blink.get_lsp_capabilities()
end

vim.lsp.config('*', {
  handlers = handlers,
  capabilities = capabilities,
  flags = {
    debounce_text_cahnges = 500,
  },
})

vim.lsp.enable(lsp_list)
