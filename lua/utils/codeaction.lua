local lsp = vim.lsp
local logger = require('utils.logger').Logger
local nmenu = require('nui.menu')
local ntext = require('nui.text')
local event = require('nui.utils.autocmd').event

local cfg = {
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

local ms = {
  textDocument_codeAction = 'textDocument/codeAction',
  codeAction_resolve = 'codeAction/resolve',
}

local fmt_title = function(name)
  if name then
    return ('[LSP][%s]Code action'):format(name)
  else
    return '[LSP]Code action'
  end
end

---@param bufnr integer
---@param mode "v"|"V"
---@return table {start={row,col}, end={row,col}} using (1, 0) indexing
local function range_from_selection(bufnr, mode)
  -- TODO: Use `vim.fn.getregionpos()` instead.

  -- [bufnum, lnum, col, off]; both row and column 1-indexed
  local start = vim.fn.getpos('v')
  local end_ = vim.fn.getpos('.')
  local start_row = start[2]
  local start_col = start[3]
  local end_row = end_[2]
  local end_col = end_[3]
  vim.print(start)
  vim.print(end_)
  vim.print(vim.fn.getregionpos(start, end_))
  -- A user can start visual selection at the end and move backwards
  -- Normalize the range to start < end
  if start_row == end_row and end_col < start_col then
    end_col, start_col = start_col, end_col --- @type integer, integer
  elseif end_row < start_row then
    start_row, end_row = end_row, start_row --- @type integer, integer
    start_col, end_col = end_col, start_col --- @type integer, integer
  end
  if mode == 'V' then
    start_col = 1
    local lines = vim.api.nvim_buf_get_lines(bufnr, end_row - 1, end_row, true)
    end_col = #lines[1]
  end
  return {
    ['start'] = { start_row, start_col - 1 },
    ['end'] = { end_row, end_col - 1 },
  }
end

local function apply_action(action, client, ctx)
  if action.edit then
    lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    logger.info(action.title, fmt_title(client.name))
  end
  local acmd = action.command
  if acmd then
    local command = type(acmd) == 'table' and acmd or action
    client:exec_cmd(command, ctx)
    logger.info(command.title, fmt_title(client.name))
  end
end

local function window(itemList, onSubmit)
  local popup_opts = {
    position = {
      row = 3,
      col = 0,
    },
    relative = 'cursor',
    border = {
      style = cfg.border.style,
      text = {
        top = ntext(cfg.title.text, cfg.title.hl),
        top_align = cfg.title.align,
      },
      padding = { 0, 1, 1, 1 },
    },
    win_options = {
      winhighlight = cfg.hl,
    },
  }

  local menu_opts = {
    lines = itemList,
    min_width = cfg.min_width,
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
  local client = assert(lsp.get_client_by_id(item.ctx.client_id))
  local action, ctx = item.action, item.ctx
  local bufnr = assert(item.ctx.bufnr, 'Must have buffer number')

  if type(action.title) == 'string' and type(action.command) == 'string' then
    apply_action(action, client, ctx)
    return
  end
  if not (action.edit and action.command) and client:supports_method(ms.codeAction_resolve) then
    client:request(ms.codeAction_resolve, action, function(err, resolved_action)
      if err then
        if action.edit or action.command then
          apply_action(action, client, ctx)
        else
          logger.error(err.code .. ': ' .. err.message, fmt_title(client.name))
        end
      else
        apply_action(resolved_action, client, ctx)
      end
    end, bufnr)
  else
    apply_action(action, client)
  end
end

local function on_code_action_results(results)
  if not results then
    logger.warn('No results from textDocument/codeAction', fmt_title())
    return
  end
  local itemList = {}

  for client_id, result in pairs(results) do
    if result.result and not vim.tbl_isempty(result.result) then
      local client = assert(lsp.get_client_by_id(client_id))
      table.insert(itemList, nmenu.separator(ntext('[' .. client.name .. ']', cfg.separator.hl), cfg.separator))
      for _, action in ipairs(result.result) do
        table.insert(itemList, nmenu.item(action.title, { action = action, ctx = result.ctx }))
      end
    end
  end

  if #itemList == 0 then
    logger.warn('No code actions available', fmt_title())
    return
  end

  local menu = window(itemList, onSubmit)
  menu:mount()
  vim.api.nvim_buf_call(menu.bufnr, function()
    if vim.fn.mode() ~= 'n' then
      vim.api.nvim_input('<Esc>')
    end
  end)
  menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end

local function codeAction()
  local context = { triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked }
  local mode = vim.api.nvim_get_mode().mode
  local bufnr = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = ms.textDocument_codeAction })
  local remaining = #clients
  if remaining == 0 then
    if next(vim.lsp.get_clients({ bufnr = bufnr })) then
      vim.notify(vim.lsp._unsupported_method(ms.textDocument_codeAction), vim.log.levels.WARN)
    end
    return
  end

  local results = {}

  local function on_result(err, result, ctx)
    results[ctx.client_id] = { error = err, result = result, ctx = ctx }
    remaining = remaining - 1
    if remaining == 0 then
      on_code_action_results(results)
    end
  end

  for _, client in ipairs(clients) do
    local params
    if mode == 'v' or mode == 'V' then
      local range = range_from_selection(bufnr, mode)
      params = vim.lsp.util.make_given_range_params(range['start'], range['end'], bufnr, client.offset_encoding)
    else
      params = vim.lsp.util.make_range_params(win, client.offset_encoding)
    end
    local ns_push = vim.lsp.diagnostic.get_namespace(client.id, false)
    local ns_pull = vim.lsp.diagnostic.get_namespace(client.id, true)
    local diagnostics = {}
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, { namespace = ns_pull, lnum = lnum }))
    vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, { namespace = ns_push, lnum = lnum }))
    ---@diagnostic disable-next-line: inject-field
    params.context = vim.tbl_extend(
      'force',
      context,
      { diagnostics = vim.tbl_map(function(d)
        return d.user_data.lsp
      end, diagnostics) }
    )
    client:request(ms.textDocument_codeAction, params, on_result, bufnr)
  end
end

return {
  code_action = codeAction,
  range_code_action = codeAction,
}
