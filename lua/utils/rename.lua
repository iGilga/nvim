local lsp = vim.lsp
local Input = require('nui.input')
local event = require('nui.utils.autocmd').event

local Text = require('nui.text')

local config = {
  min_width = 40,
  border = {
    highlight = 'NuiBorder',
    style = 'solid',
    title = ' Rename ',
    title_align = 'center',
    title_hl = 'NuiTitle',
  },
  prompt = ' > ',
  prompt_hl = 'NuiPrompt',
  highlight = 'Normal:NuiNormal',
}

local M = {}

local minWidth = config.min_width or 30

local map = function(input, lhs, rhs)
  input:map('i', lhs, rhs, { noremap = true }, false)
end

local prompt_backspace = function(prompt)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1]
  local col = cursor[2]
  if col ~= prompt then
    vim.api.nvim_buf_set_text(0, line - 1, col - 1, line - 1, col, { '' })
    vim.api.nvim_win_set_cursor(0, { line, col - 1 })
  end
end

local mappings = function(input)
  local prompt = input._.prompt._length

  map(input, '<ESC>', function()
    input.input_props.on_close()
  end)

  map(input, '<C-c>', function()
    input.input_props.on_close()
  end)
  map(input, '<BS>', function()
    prompt_backspace(prompt)
  end)
end

M.rename = function(popup_opts, opts)
  local curName = vim.fn.expand('<cword>')
  local width = minWidth
  if #curName > width then
    width = #curName
  end
  popup_opts = {
    position = {
      row = 1,
      col = -3,
    },
    size = {
      width = width,
    },
    relative = 'cursor',
    highlight = config.highlight,
    border = {
      highlight = config.border.highlight,
      style = config.border.style,
      char = ' ',
      padding = { -1, -1 },
    },
  }
  opts = {
    prompt = Text(config.prompt, config.prompt_hl),
    default_value = curName,
    on_submit = function(newName)
      if not (newName and #newName > 0) or newName == curName then
        return
      end
      lsp.buf.rename(newName)
    end,
  }
  local input = Input(popup_opts, opts)
  -- mount/open the component
  input:mount()
  mappings(input)
  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return M
