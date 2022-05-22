local levels = vim.log.levels

local ok, load_notify = pcall(require, 'notify')

if ok then
  load_notify.setup({
    stages = 'fade',
    on_open = function(win)
      P(win)
      -- [ "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" ]
      vim.api.nvim_win_set_config(win, { border = { '', ' ', '', '', '', ' ', '', '' } })
    end,
    timeout = 2000,
  })
  vim.notify = load_notify
end

local namespace = vim.api.nvim_create_namespace('nvim-notify')

local customRender = function(bufnr, notif, highlights)
  local hlSign = 'Notify' .. notif.level .. 'Sign'
  local title = notif.message[2]
  local message = notif.message[1]
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { '', '' })
  vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
    virt_text = {
      { ' ', hlSign },
      { ' ' },
      { title, highlights.icon },
    },
    priority = 10,
    virt_text_win_col = 0,
  })
  vim.api.nvim_buf_set_extmark(bufnr, namespace, 1, 0, {
    virt_text = {
      { ' ', hlSign },
      { ' ' },
      { message, highlights.body },
    },
    priority = 50,
    virt_text_win_col = 0,
  })
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

local customOption = { render = customRender }

M.minfo = function(title, message)
  vim.notify({ message, title }, 'info', customOption)
end

M.mwarn = function(title, message)
  vim.notify({ message, title }, 'warn', customOption)
end

M.merror = function(title, message)
  vim.notify({ message, title }, 'error', customOption)
end

return M
