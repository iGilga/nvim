local levels = vim.log.levels

local ok, load_notify = pcall(require, 'notify')

if ok then
  load_notify.setup({
    stages = 'fade',
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { border = { ' ' } })
    end,
    timeout = 1000,
  })
  vim.notify = load_notify
end

local M = {}

M.init = function() end

M.info = function(text, opt)
  vim.notify(text, levels.INFO, opt)
end

M.warn = function(text, opt)
  vim.notify(text, levels.WARN, opt)
end

M.error = function(text, opt)
  vim.notify(text, levels.WARN, opt)
end

local renderOption = { render = 'minimal' }

M.minfo = function(text)
  vim.notify(text, 'info', renderOption)
end

M.mwarn = function(text)
  vim.notify(text, levels.WARN, renderOption)
end

M.merror = function(text)
  vim.notify(text, levels.WARN, renderOption)
end

return M
