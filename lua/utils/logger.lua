local levels = vim.log.levels

local M = {}

M.Logger = {}
M.Logger.__index = M.Logger

local log = function(type, msg, opts)
  local ok, notify = pcall(require, 'notify')
  if ok then
    notify(msg, type, opts)
  else
    if vim.tbl_islist(msg) then
      local tmp_list = msg
      msg = ''
      for _, v in pairs(tmp_list) do
        msg = msg .. v
      end
    end
    vim.notify(msg, type)
  end
end

function M.Logger.info(msg, title)
  log(vim.log.levels.INFO, msg, { title = title })
end

function M.Logger.warn(msg, title)
  log(vim.log.levels.WARN, msg, { title = title })
end

function M.Logger.error(msg, title)
  log(vim.log.levels.ERROR, msg, { title = title })
end

function M.Logger.hint(text, title)
  vim.notify(text, levels.TRACE, { title = title })
end

return M
