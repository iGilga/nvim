local u = require('utils')
local logger = require('utils.logger').Logger
local border = require('config.user').border

local M = {}

function M.on_attach(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  if vim.fn.has("nvim-0.10.0") == 1 then
    if client.supports_method('textDocument/inlayHint') and vim.lsp.inlay_hint.is_enabled then
      vim.lsp.inlay_hint.enable(bufnr, true)
    end
  end

  require('lsp.mapping').init(client)
end

local capabilities = {}
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities()
end

M.capabilities = capabilities

M.flags = {
  debounce_text_changes = 200,
}

M.handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = border,
  }),

  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = border,
  }),
  ['textDocument/rename'] = function(_, result, ctx)
    if result and not vim.tbl_isempty(result) then
      local p = ctx.params
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
      if result.documentChanges then
        for _, c in ipairs(result.documentChanges) do
          local msg = ('%s [%s][%d]'):format(p.newName, u.getRelativePath(c.textDocument.uri), #c.edits)
          logger.info(msg, '[LSP]Rename')
        end
      elseif result.changes then
        for k, c in pairs(result.changes) do
          local msg = ('%s [%s][%d]'):format(p.newName, u.getRelativePath(k), #c)
          logger.info(msg, '[LSP]Rename')
        end
      end
    end
  end,
  ['textDocument/definition'] = function(_, result, ctx)
    P(result)
    P(ctx)
  end
}

return M
