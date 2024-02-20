local M = {}

function M.getRelativePath(file_path)
  local plenary_path = require('plenary.path')
  local parsed_path, _ = file_path:gsub('file://', '')
  local path = plenary_path:new(parsed_path)
  local relative_path = path:make_relative(vim.fn.getcwd())
  return './' .. relative_path
end

function M.load(name)
  vim.api.nvim_command(('colorscheme %s'):format(name))
end

return M
