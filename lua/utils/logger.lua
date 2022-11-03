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
    lines[1] = set_config(title, highlights.title, 10)
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
  timeout = 2000,
})

vim.notify = moduleNotify

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
