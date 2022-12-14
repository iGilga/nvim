local lsp = vim.lsp
local config = require('config').codeAction
local logger = require('utils.logger').Logger
local nmenu = require('nui.menu')
local ntext = require('nui.text')
local event = require('nui.utils.autocmd').event

local minWidth = config.min_width or 0

local title = function(name)
  if name then
    return ('[LSP][%s]Code Action'):format(name)
  else
    return '[LSP]Code Action'
  end
end

local index_of = function(tbl, item)
  for i, value in ipairs(tbl) do
    if value == item then
      return i
    end
  end
end

local function applyAction(action, client)
  local isCommand = type(action.command) == 'table'
  if action.edit then
    lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    logger.info(action.title, title(client.name))
  end
  if action.command then
    if isCommand then
      lsp.buf.execute_command(action.command)
      logger.info(action.title, title(client.name))
    else
      lsp.buf.execute_command(action)
      logger.info(action.title, title(client.name))
    end
  end
end

local function onChange(actionList)
  return function(item, menu)
    local pos = index_of(actionList, item)
    local text = ' ' .. tostring(pos) .. '/' .. #actionList .. ' '
    menu.border:set_text('bottom', ntext(text, config.border.bottom_hl), 'right')
  end
end

local function window(itemList, actionList, onSubmit)
  local popup_opts = {
    position = {
      row = 1,
      col = 0,
    },
    relative = 'cursor',
    highlight = config.highlight or 'Normal:Normal',
    border = {
      highlight = config.border.highlight,
      style = config.border.style,
      text = {
        top = ntext(config.border.title, config.border.title_hl),
        top_align = config.border.title_align,
      },
      padding = { 0, 1, 1, 1 },
    },
  }

  return nmenu(popup_opts, {
    lines = itemList,
    min_width = minWidth,
    separator = config.separator,
    keymap = {
      focus_next = { 'j', '<Down>', '<Tab>' },
      focus_prev = { 'k', '<Up>', '<S-Tab>' },
      close = { 'h', '<Esc>', '<C-c>' },
      submit = { '<CR>', '<Space>' },
    },
    on_change = onChange(actionList),
    on_submit = onSubmit,
  })
end

local function onSubmit(item)
  local action = item.ctx.command
  local client = item.ctx.client

  if
    not action.edit
    and client
    and type(client.server_capabilities.codeAction) == 'table'
    and client.server_capabilities.codeAction.resolveProvider
  then
    client.request('codeAction/resolve', action, function(err, resolvedAction)
      if err then
        logger.error(err.code .. ': ' .. err.message, title(client.name))
        return
      end
      applyAction(resolvedAction, client)
    end)
  else
    applyAction(action, client)
  end
end

local function codeActionCallback(results)
  if not results then
    logger.warn('No results from textDocument/codeAction', title())
    return
  end

  local itemList = {}
  local actionList = {}

  for client_id, response in pairs(results) do
    if response.result and not vim.tbl_isempty(response.result) then
      local client = lsp.get_client_by_id(client_id)
      table.insert(itemList, nmenu.separator(ntext('[' .. client.name .. ']', 'NuiSeparator')))
      for _, action in ipairs(response.result) do
        local title = action.title
        local item = nmenu.item(action.title)
        item.ctx = {
          title = title,
          client = client,
          clientName = client and client.name or '',
          command = action,
        }
        minWidth = math.max(minWidth, #title, 30)
        table.insert(itemList, item)
        table.insert(actionList, item)
      end
    end
  end

  if #actionList == 0 then
    logger.warn('No code actions available', title())
    return
  end

  local menu = window(itemList, actionList, onSubmit)
  menu:mount()

  vim.api.nvim_buf_call(menu.bufnr, function()
    if vim.fn.mode() ~= 'n' then
      vim.api.nvim_input('<Esc>')
    end
  end)

  -- close menu when cursor leaves buffer
  menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end

local function codeActionRequest(params)
  local bfnr = vim.api.nvim_get_current_buf()
  local method = 'textDocument/codeAction'
  vim.lsp.buf_request_all(bfnr, method, params, codeActionCallback)
end

local function codeAction(ctx)
  local params = lsp.util.make_range_params()
  local context = ctx or { diagnostics = lsp.diagnostic.get_line_diagnostics() }
  params.context = context
  codeActionRequest(params)
end

local function rangeCodeAction(ctx, startPos, endPos)
  local params = lsp.util.make_given_range_params(startPos, endPos)
  local context = ctx or { diagnostics = lsp.diagnostic.get_line_diagnostics() }
  params.context = context
  codeActionRequest(params)
end

return {
  code_action = codeAction,
  range_code_action = rangeCodeAction,
}
