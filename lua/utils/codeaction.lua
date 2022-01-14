local nmenu = require('nui.menu')
local ntext = require('nui.text')
local event = require('nui.utils.autocmd').event

local M = {}

local default_border = 'rounded'
local default_user_opts = {
  border_style = default_border,
  rename = {
    border = {
      highlight = 'FloatBorder',
      style = nil,
      title = 'Rename',
      title_align = 'left',
      title_hl = 'FloatBorder',
    },
    prompt = '> ',
    prompt_hl = 'Comment',
  },
  code_actions = {
    min_width = nil,
    border = {
      bottom_hl = 'FloatBorder',
      highlight = 'FloatBorder',
      style = nil,
      title = 'Code Actions',
      title_align = 'center',
      title_hl = 'FloatBorder',
    },
  },
}

local index_of = function (tbl, item)
  for i, value in ipairs(tbl) do
    if value == item then
      return i
    end
  end
end

M.code_actions = function(opts)
  opts = {
    timeout = 2000,
    params = vim.lsp.util.make_range_params(),
  }

  opts.params.context = {
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
  }
  local results_lsp, _ = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', opts.params, opts.timeout)

  if not results_lsp or vim.tbl_isempty(results_lsp) then
    print('No results from textDocument/codeAction')
    return
  end

  local menu_items = {}

  local result_items = {}
  local min_width = 0

  for client_id, response in pairs(results_lsp) do
    if response.result and not vim.tbl_isempty(response.result) then
      local client = vim.lsp.get_client_by_id(client_id)
      table.insert(menu_items, nmenu.separator(ntext('(' .. client.name .. ')', 'Comment')))

      for _, result in pairs(response.result) do
        local command_title = result.title:gsub('\r\n', '\\r\\n'):gsub('\n', '\\n')
        local item = nmenu.item(command_title)
        item.ctx = {
          command_title = command_title,
          client = client,
          client_name = client and client.name or '',
          command = result,
        }
        min_width = math.max(min_width, #command_title, 30)
        table.insert(menu_items, item)
        table.insert(result_items, item)
      end
    end
  end
  if #menu_items == 0 then
    print('No code actions available')
    return
  end
  local popup_opts = {
    position = {
      row = 1,
      col = 0,
    },
    relative = 'cursor',
    border = {
      highlight = 'FloatBorder',
      style = default_user_opts.border_style,
      text = {
        top = ntext('Code Actions'),
        top_align = 'center',
      },
      padding = { 0, 1 },
    },
    wim_options = {
      winhighlight = 'Normal:Normal',
    },
  }
  local menu = nmenu(popup_opts, {
    lines = menu_items,
    min_width = min_width,
    separator = {
      char = '·',
      text_align = 'center',
    },
    keymap = {
      focus_next = { 'j', '<Down>', '<Tab>' },
      focus_prev = { 'k', '<Up>', '<S-Tab>' },
      close = { '<Esc>', '<C-c>' },
      submit = { '<CR>', '<Space>' },
    },
    on_change = function(item, menu)
      local pos = index_of(result_items, item)
      menu.border:set_text('bottom', '(' .. tostring(pos) .. '/' .. #result_items .. ')', 'right')
    end,
    on_submit = function(item)
      local action = item.ctx.command
      local client = item.ctx.client

      if
        not action.edit
        and client
        and type(client.resolved_capabilities.code_action) == 'table'
        and client.resolved_capabilities.code_action.resolveProvider
      then
        client.request('codeAction/resolve', action, function(resolved_err, resolved_action)
          if resolved_err then
            print(resolved_err .. ': ' .. resolved_err.message)
            return
          end
          if resolved_action then
            execute_action(transform_action(resolved_action))
          else
            execute_action(transform_action(action))
          end
        end)
      else
        execute_action(transform_action(action))
      end
    end,
  })

  menu:mount()

  vim.api.nvim_buf_call(menu.bufnr, function()
    if vim.fn.mode() ~= 'n' then
      vim.api.nvim_imput('<Esc>')
    end
  end)

  menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end

return M
