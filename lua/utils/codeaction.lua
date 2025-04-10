local lsp = vim.lsp
local logger = require('utils.logger').Logger
local nmenu = require('nui.menu')
local ntext = require('nui.text')
local event = require('nui.utils.autocmd').event

local config = {
  min_width = 60,
  title = {
    text = ' Code Actions ',
    align = 'center',
    hl = 'NuiTitle',
  },
  bottom = {
    hl = 'NuiBottom',
  },
  border = {
    style = 'solid',
  },
  separator = {
    char = '',
    text_align = 'left',
    hl = 'NuiSeparator',
  },
  hl = 'NormalFloat:NuiNormal,FloatBorder:NuiBorder',
}

local fmt_title = function(name)
  if name then
    return ('[LSP][%s]Code action'):format(name)
  else
    return '[LSP]Code action'
  end
end

local function applyAction(action, client)
  local isCommand = type(action.command) == 'table'
  if action.edit then
    lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    logger.info(action.title, fmt_title(client.name))
  end
  if action.command then
    if isCommand then
      client:exec_cmd(action.command)
      logger.info(action.title, fmt_title(client.name))
    else
      client:exec_cmd(action)
      logger.info(action.title, fmt_title(client.name))
    end
  end
end

local function window(itemList, _, onSubmit)
  local popup_opts = {
    position = {
      row = 3,
      col = 0,
    },
    relative = 'cursor',
    border = {
      style = config.border.style,
      text = {
        top = ntext(config.title.text, config.title.hl),
        top_align = config.title.align,
      },
      padding = { 0, 1, 1, 1 },
    },
    win_options = {
      winhighlight = config.hl,
    },
  }

  local menu_opts = {
    lines = itemList,
    min_width = config.min_width,
    keymap = {
      focus_next = { 'j', '<Down>', '<Tab>' },
      focus_prev = { 'k', '<Up>', '<S-Tab>' },
      close = { 'h', '<Esc>', '<C-c>' },
      submit = { '<CR>', '<Space>' },
    },
    on_submit = onSubmit,
  }

  return nmenu(popup_opts, menu_opts)
end

local function onSubmit(item)
  local action = item.ctx.command
  local client = item.ctx.client

  if
    not action.edit
    and client
    and type(client.server_capabilities.codeActionProvider) == 'table'
    and client.server_capabilities.codeActionProvider.resolveProvider
  then
    client.request('codeAction/resolve', action, function(err, resolvedAction)
      if err then
        logger.error(err.code .. ': ' .. err.message, fmt_title(client.name))
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
    logger.warn('No results from textDocument/codeAction', fmt_title())
    return
  end

  local itemList = {}
  local actionList = {}

  for client_id, response in pairs(results) do
    if response.result and not vim.tbl_isempty(response.result) then
      local client = lsp.get_client_by_id(client_id)
      table.insert(itemList, nmenu.separator(ntext('[' .. client.name .. ']', config.separator.hl), config.separator))
      for _, action in ipairs(response.result) do
        local title = action.title
        local item = nmenu.item(action.title)
        item.ctx = {
          title = title,
          client = client,
          clientName = client and client.name or '',
          command = action,
        }
        table.insert(itemList, item)
        table.insert(actionList, item)
      end
    end
  end

  if #actionList == 0 then
    logger.warn('No code actions available', fmt_title())
    return
  end

  local menu = window(itemList, actionList, onSubmit)
  menu:mount()

  vim.api.nvim_buf_call(menu.bufnr, function()
    if vim.fn.mode() ~= 'n' then
      vim.api.nvim_input('<Esc>')
    end
  end)
  menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end

local function codeActionRequest(bufnr, params)
  local method = 'textDocument/codeAction'
  vim.lsp.buf_request_all(bufnr, method, params, codeActionCallback)
end

local function codeAction()
  local bufnr = vim.api.nvim_get_current_buf()
  local params = lsp.util.make_range_params(0, 'utf-32')
  local context = { diagnostics = vim.diagnostic.get(bufnr) }
  params.context = context
  codeActionRequest(bufnr, params)
end

-- local function rangeCodeAction()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local params = lsp.util.make_given_range_params(startPos, endPos, 0, 'utf-32')
--   local context = { diagnostics = lsp.diagnostic.get(bufnr) }
--   params.context = context
-- end

return {
  code_action = codeAction,
  -- range_code_action = rangeCodeAction,
}
