local capabilities = {}
local ok, blink = pcall(require, 'blink')
if ok then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = { 'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact' },
  root_markers = { '.git', 'package.json' },
  single_file_support = true,
  settings = {},
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = capabilities,
}
