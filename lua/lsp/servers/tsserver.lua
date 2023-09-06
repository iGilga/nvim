local u = require('utils')
local defaultOnAttach = require('lsp.servers.default').on_attach
local config = require('config.user')

local M = {}

local capabilities = {}

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities()

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

local function on_attach(client, bufnr)
  defaultOnAttach(client, bufnr)
  -- local function buf_set_option(...)
  --   vim.api.nvim_buf_set_option(bufnr, ...)
  -- end
  --
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local handlers = {
  -- ['textDocument/publishDiagnostics'] = vim.lsp.with(
  --   vim.lsp.diagnostic.on_publish_diagnostics,
  --   { signs = function() end }
  -- ),
  -- ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = EcoVim.ui.float.border }),
  -- ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = EcoVim.ui.float.border }),
  -- ['textDocument/definition'] = function(err, result, method, ...)
  --   if vim.tbl_islist(result) and #result > 1 then
  --     local filtered_result = filter(result, filterReactDTS)
  --     return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
  --   end
  --
  --   vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
  -- end,
}

local settings = {
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
}

M.capabilities = capabilities
-- M.on_attach = on_attach
-- M.handlers = handlers
-- M.settings = settings
return M
