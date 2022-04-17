local lsp = vim.lsp
local Input = require('nui.input')
local event = require('nui.utils.autocmd').event

local Text = require('nui.text')

local M = {}

local config = {
  border = {
    highlight = 'FloatBorder',
    style = 'rounded',
    title = '[Rename]',
    title_align = 'left',
    title_hl = 'FloatBorder',
  },
  prompt = '> ',
  prompt_hl = 'Comment',
}

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

local utils = {
  merge = function(...)
    return vim.tbl_deep_extend('force', ...)
  end,
  default_mappings = function(input)
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
  end,
}
local rename_handler = function(err, result, ctx, _)
  if err then
    vim.notify(("Error running LSP query '%s': %s"):format(ctx.method, err), vim.log.levels.ERROR, {
      title = 'Cosmic-UI',
    })
  end

  if not result then
    return
  end

  vim.lsp.util.apply_workspace_edit(result)
  local total_files = vim.tbl_count(result.documentChanges[1].edits)
  vim.notify(
    ('Changed %s time%s.'):format(total_files, total_files > 1 and 's' or ''),
    vim.log.levels.INFO,
    { title = 'Rename' }
  )
end

M.rename = function(popup_opts, opts)
  local curr_name = vim.fn.expand('<cword>')

  local width = 25
  if #curr_name > width then
    width = #curr_name
  end

  popup_opts = utils.merge({
    position = {
      row = 1,
      col = 0,
    },
    size = {
      width = width,
      height = 2,
    },
    relative = 'cursor',
    border = {
      highlight = config.border.highlight,
      style = config.border.style,
      text = {
        top = Text(config.border.title, config.border.title_hl),
        top_align = config.border.title_align,
      },
    },
  }, popup_opts or {})

  opts = utils.merge({
    prompt = Text(config.prompt, config.prompt_hl),
    default_value = curr_name,
    on_submit = function(new_name)
      if not (new_name and #new_name > 0) or new_name == curr_name then
        return
      end
      local params = lsp.util.make_position_params()
      params.newName = new_name
      lsp.buf_request(0, 'textDocument/rename', params, rename_handler)
    end,
  }, opts or {})

  local input = Input(popup_opts, opts)

  -- mount/open the component
  input:mount()

  utils.default_mappings(input)

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return M
