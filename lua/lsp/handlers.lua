local u = require('utils')
local logger = require('utils.logger').Logger

return {
  ['textDocument/rename'] = function(_, result, ctx)
    if result and not vim.tbl_isempty(result) then
      local p = ctx.params
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if client == nil then
        logger.error('Cant find client', '[LSP]')
        return
      end
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
}
