local levels = vim.log.levels

local ok, moduleNotify = pcall(require, 'notify')

if not ok then
  return false
end

local namespace = vim.api.nvim_create_namespace('nvim-notify')

local customRender = function(bufnr, notif, highlights)
  local hlSign = 'Notify' .. notif.level .. 'Sign'
  local title = notif.title[1]
  local message = notif.message

  local set_config = function(text, hl, priority)
    return {
      virt_text = {
        { ' ', hlSign },
        { ' ' },
        { text, hl },
      },
      priority = priority,
      virt_text_win_col = 0,
    }
  end
  local lines = {}

  if not (title == nil or title == '') then
    lines[1] = set_config(title, highlights.icon, 10)
  end

  local count = #lines
  local spaces = {}

  for i = 1, #message do
    lines[count + i] = set_config(message[i], highlights.body, 50)
  end
  for i = 1, #lines do
    spaces[i] = ''
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, spaces)

  for i = 1, #lines do
    vim.api.nvim_buf_set_extmark(bufnr, namespace, i - 1, 0, lines[i])
  end
end

moduleNotify.setup({
  stages = 'fade',
  render = customRender,
  on_open = function(win)
    -- [ "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" ]
    vim.api.nvim_win_set_config(win, { border = { '', ' ', '', '', '', ' ', '', '' } })
  end,
  timeout = 12000,
})
vim.notify = moduleNotify

local M = {}

M.info = function(text, title)
  vim.notify(text, levels.INFO, { title = title })
end

M.warn = function(text, title)
  vim.notify(text, levels.WARN, { title = title })
end

M.error = function(text, title)
  vim.notify(text, levels.ERROR, { title = title })
end

M.hint = function(text, title)
  vim.notify(text, levels.TRACE, { title = title })
end

return M
