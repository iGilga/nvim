local config = require("config")

local M = {}

function M.merge(...)
  return vim.tbl_deep_extend('force', ...)
end

function M.isClientFormat(clientName)
  if config.lsp.servers[clientName] then
    return (config.lsp.servers[clientName].formatter == true)
  end

  return true
end

function M.isDisable(plugin)
  return vim.tbl_contains(config.disablePlugins, plugin)
end

function M.get_relative_path(file_path)
  local plenary_path = require('plenary.path')
  local parsed_path, _ = file_path:gsub('file://', '')
  local path = plenary_path:new(parsed_path)
  local relative_path = path:make_relative(vim.fn.getcwd())
  return './' .. relative_path
end

return M
