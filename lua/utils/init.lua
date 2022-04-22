local config = require("config")

local M = {}

function M.merge(...)
  return vim.tbl_deep_extend('force', ...)
end

function M.can_client_format(client_name)
  if config.lsp.servers[client_name] == true then
    return true
  end

  if vim.tbl_contains(vim.tbl_keys(config.lsp.servers), client_name) and config.lsp.servers[client_name] then
    return (config.lsp.servers[client_name].format == true)
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
