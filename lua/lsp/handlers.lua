local lsp = vim.lsp
local border = require('config').border
local get_relative_path = require('utils').get_relative_path
local logger = require('utils.logger')

lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, {
  border = border,
})

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, {
  border = border,
})

lsp.handlers['textDocument/formatting'] = function(_, result, ctx)
  if result then
    local client = lsp.get_client_by_id(ctx.client_id)
    lsp.util.apply_text_edits(result, ctx.bufnr, client.offset_encoding)
    -- local msg = ('[LSP]Formatting done. [%s]'):format(get_relative_path(ctx.params.textDocument.uri))
    local msg = '[LSP]Formatting done.'
    logger.minfo(msg)
  end
end

-- TODO no work
lsp.handlers['textDocument/definition'] = function(_, result, ctx)
  P(ctx)
  if not result or vim.tbl_isempty(result) then
    logger.warn('[LSP] Could not find definition', { title = '[LSP]Definition' })
    return
  end

  local client = lsp.get_client_by_id(ctx.client_id)
  if vim.tbl_islist(result) then
    lsp.util.jump_to_location(result[1], client.offset_encoding)
  else
    lsp.util.jump_to_location(result, client.offset_encoding)
  end
end
