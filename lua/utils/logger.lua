local levels = vim.log.levels

local ok, load_notify = pcall(require, 'notify')

if ok then
  load_notify.setup({
    stages = 'fade',
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { border = { ' ' } })
    end,
    timeout = 2000,
  })
  vim.notify = load_notify
end

local namespace = vim.api.nvim_create_namespace('nvim-notify')

local customRender = function(bufnr, notif, highlights)
  local left_icon = notif.icon .. ' '
  local message = { string.rep(' ', 3) .. notif.message[1] }
  vim.api.nvim_buf_set_lines(bufnr, 1, -1, false, message)
  vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
    virt_text = {
      { ' ' },
      { left_icon, highlights.icon },
      { notif.message[2], highlights.icon },
    },
    priority = 50,
    virt_text_win_col = 0,
    hl_group = highlights.body,
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

local renderOption = { render = customRender }

M.minfo = function(title, message)
  vim.notify({ message, title }, 'info', renderOption)
end

M.mwarn = function(title, message)
  vim.notify({ message, title }, 'warn', renderOption)
end

M.merror = function(title, message)
  vim.notify({ message, title }, 'error', renderOption)
end

return M
