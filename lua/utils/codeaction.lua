local nmenu = require('nui.menu')
local ntext = require('nui.text')
local event = require('nui.utils.autocmd').event

local util = vim.lsp.util
local config = {
  min_width = nil,
  border = {
    bottom_hl = 'FloatBorder',
    highlight = 'FloatBorder',
    style = 'rounded',
    title = 'Code Actions',
    title_align = 'center',
    title_hl = 'FloatBorder',
  },
}

local minWidth = 0

local index_of = function(tbl, item)
  for i, value in ipairs(tbl) do
    if value == item then
      return i
    end
  end
end

local function executeAction(action)
  local isCommand = type(action.command) == 'table'
  if action.edit or isCommand then
    if action.edit then
      util.apply_workspace_edit(action.edit)
    end
    if isCommand then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

local function onChange(actionList)
  return function(item, menu)
    local pos = index_of(actionList, item)
    local text = '(' .. tostring(pos) .. '/' .. #actionList .. ')'
    menu.border:set_text('bottom', ntext(text, config.border.bottom_hl), 'right')
  end
end

local function onSubmit(item)
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
        vim.notify(resolved_err.code .. ': ' .. resolved_err.message, vim.log.levels.ERROR)
        return
      end
      executeAction(resolved_action)
    end)
  else
    executeAction(action)
  end
end

local function window(itemList, actionList)
  local popup_opts = {
    position = {
      row = 1,
      col = 0,
    },
    relative = 'cursor',
    border = {
      highlight = config.border.highlight,
      style = config.border.style,
      text = {
        top = ntext(config.border.title, config.border.title_hl),
        top_align = config.border.title_align,
      },
      padding = { 0, 1 },
    },
    wim_options = {
      winhighlight = 'Normal:Normal',
    },
  }
  local menu = nmenu(popup_opts, {
    lines = itemList,
    min_width = minWidth,
    separator = {
      char = ' ',
      text_align = 'center',
    },
    keymap = {
      focus_next = { 'j', '<Down>', '<Tab>' },
      focus_prev = { 'k', '<Up>', '<S-Tab>' },
      close = { '<Esc>', '<C-c>' },
      submit = { '<CR>', '<Space>' },
    },
    on_change = onChange(actionList),
    on_submit = onSubmit,
  })
  return menu
end

local function onCodeActionResponse(results)
  local itemList = {}
  local actionList = {}
  if not results then
    vim.notify('no results')
  end
  for client_id, response in pairs(results) do
    if response.result and not vim.tbl_isempty(response.result) then
      local client = vim.lsp.get_client_by_id(client_id)
      table.insert(itemList, nmenu.separator(ntext('(' .. client.name .. ')', 'Comment')))
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

  if #itemList == 0 then
    vim.notify('No results from textDocument/codeAction', vim.log.levels.WARN, {
      title = 'CodeAction',
    })
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

local function codeActionCallback(ctx)
  return onCodeActionResponse
end

local function testcb()
  return onCodeActionResponse
end

local function codeActionRequest(params)
  local bfnr = vim.api.nvim_get_current_buf()
  local method = 'textDocument/codeAction'
  -- local callback = codeActionCallback({ bufnr = bfnr, method = method, params = params })
  -- local callback = testcb
  local result = vim.lsp.buf_request_sync(bfnr, method, params)
  onCodeActionResponse(result)
end

local function codeAction(opt)
  print('codeAction')
  local params = util.make_range_params()
  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  params.context = context
  codeActionRequest(params)
end

local function rangeCodeAction(ctx, startPos, endPos)
  local params = util.make_given_range_params(startPos, endPos)
  local context = ctx or { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  params.context = context
  codeActionRequest(params)
end

return {
  code_action = codeAction,
  range_code_action = rangeCodeAction,
}
