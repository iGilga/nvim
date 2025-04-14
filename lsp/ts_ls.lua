local capabilities = {}
local ok, blink = pcall(require, 'blink')
if ok then
  capabilities = blink.get_lsp_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  }

  capabilities.textDocument.codeAction = {
    dynamicRegistration = false,
    codeActionLiteralSupport = {
      codeActionKind = {
        valueSet = {
          '',
          'quickfix',
          'refactor',
          'refactor.extract',
          'refactor.inline',
          'refactor.rewrite',
          'source',
          'source.organizeImports',
        },
      },
    },
  }
end

return {
  init_options = { hostInfo = 'neovim' },
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact' },
  -- root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
  root_markers = { '.git', 'package.json' },
  single_file_support = true,
  settings = {
    tsserver = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        diagnostics = false,
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- if client.name == 'tsserver' then
    --   buf_set_keymap('n', '<leader>gr',':TSLspRenameFile<cr>')
    --   buf_set_keymap('n', '<leader>go',':TSLspOrganize<cr>')
    --   buf_set_keymap('n', '<leader>gi',':TSLspImportAll<cr>')
    -- end
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = capabilities,
}
