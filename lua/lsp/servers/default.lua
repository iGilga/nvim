local u = require('utils')

local M = {}

function M.on_attach(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  if u.isClientFormat(client.name) then
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
  else
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
  require('lsp.mapping').init(client, bufnr)
end

local capabilities = {}
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities()
end

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

M.capabilities = capabilities

-- M.root_dir = function(fname)
--   local util = require('lspconfig').util
--   return util.root_pattern('.git')(fname)
--     or util.root_pattern('tsconfig.base.json')(fname)
--     -- or util.root_pattern('package.json')(fname)
--     or util.root_pattern('.eslintrc.js')(fname)
--     or util.root_pattern('tsconfig.json')(fname)
-- end

M.autostart = true

M.single_file_support = true

M.flags = {
  debounce_text_changes = 300,
}

return M
