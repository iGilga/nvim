local lsp = vim.lsp
local Input = require('nui.input')
local event = require('nui.utils.autocmd').event

local Text = require('nui.text')

local config = require('config').rename
local u = require('utils')
local logger = require('utils.logger')

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

local renameCallback = function(err, result, ctx, _)
  if err then
    logger.error(("Error running LSP query '%s': %s"):format(ctx.method, err), {
      title = '[LSP]Rename',
    })
  end

  if result and result.changes then
    local p = ctx.params
    local uri = p.textDocument.uri
    local client = lsp.get_client_by_id(ctx.client_id)
    lsp.util.apply_workspace_edit(result, client.offset_encoding)
    local count = #result.changes[uri]
    local msg = ('%s -> %s [%s][%d]'):format(p.curName, p.newName, u.getRelativePath(uri), count)
    local title = '[LSP]Rename'
    logger.minfo(title, msg)
  end
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
      col = 0,
    },
    size = {
      width = width,
      height = 2,
    },
    relative = 'cursor',
    highlight = config.highlight or 'Normal:Normal',
    border = {
      highlight = config.border.highlight,
      style = config.border.style,
      char = ' ',
      text = {
        top = Text(config.border.title, config.border.title_hl),
        top_align = config.border.title_align,
      },
      padding = { 1, 0 },
    },
  }

  opts = {
    prompt = Text(config.prompt, config.prompt_hl),
    default_value = curName,
    on_submit = function(newName)
      if not (newName and #newName > 0) or newName == curName then
        return
      end
      local params = lsp.util.make_position_params()
      params.curName = curName
      params.newName = newName
      lsp.buf_request(0, 'textDocument/rename', params, renameCallback)
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
