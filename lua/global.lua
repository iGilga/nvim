local config = require('config')

P = function(...)
  vim.pretty_print(...)
end

_G.valhalla = {}

function valhalla.merge(...)
  return vim.tbl_deep_extend('force', ...)
end

function valhalla.isClientFormat(clientName)
  if config.lsp.servers[clientName] then
    return (config.lsp.servers[clientName].format == true)
  end

  return false
end
