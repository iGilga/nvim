local M = {}

local nmenu = require('nui.menu')
local ntext = require('nui.text')
local nline = require('nui.line')
local event = require('nui.utils.autocmd').event

local config = {
  min_width = 80,
  text = {
    hl_gray = 'NuiGrayText'
  },
  border = {
    style = 'solid',
  },
  title = {
    align = 'center',
    hl = 'NuiTitle',
  },
  separator = {
    char = ' ',
    align = 'center',
    hl = 'NuiSeparator',
  },
  hl = 'NormalFloat:NuiNormal,FloatBorder:NuiBorder',
}

local function get_prompt_text(prompt, default_prompt)
  local prompt_text = prompt or default_prompt
  if prompt_text:sub(-1) == ":" then
    prompt_text = prompt_text:sub(1, -2)
  end
  if prompt_text:sub(-1) == " " then
    prompt_text = prompt_text:sub(1, -2)
  end
  return prompt_text
end

local function build_popup_opts(title)
  local popup_options = {
    relative = 'editor',
    position = '50%',
    border = {
      style = config.border.style,
      text = {
        top = ntext(' ' .. title .. ' ', config.title.hl),
        top_align = config.title.align,
      }
    },
    win_options = {
      winhighlight = config.hl,
    },
    zindex = 999,
  }
  return popup_options
end

local function build_lines(items, format_item)
  local menu_items = {}
  for index, item in ipairs(items) do
    if type(item) ~= 'table' then
      item = { __raw_item = item }
    end
    item.index = index
    menu_items[index] = nmenu.item(format_item(item), item)
  end
  return menu_items
end

local function build_format_item(opts, title)
  local format_item = nil
  local case = {
    ['Load Session'] = function(item)
      local path = item.dir.filename
      local dir = ntext((vim.fs.dirname(path):gsub('/home/stag', '~')) .. '/', config.text.hl_gray)
      local basename = ntext(vim.fs.basename(path), 'NuiText')
      return nline({ dir, basename })
    end
  }
  if case[title] then
    format_item = case[title]
  else
    format_item = opts.format_item or function(item)
      return tostring(item.__raw_item or item)
    end
  end
  return format_item
end

local function build_menu_opts(title, lines, on_done)
  return {
    min_width = vim.api.nvim_strwidth(title) + 40,
    lines = lines,
    on_close = function()
      on_done(nil, nil)
    end,
    on_submit = function(item)
      on_done(item.__raw_item or item, item.index)
    end,
  }
end

local function buildOptions(items, opts, on_done)
  local title = get_prompt_text(opts.prompt, "Select item")
  local format_item = build_format_item(opts, title)
  local menu_items = build_lines(items, format_item)

  local popup_opts = build_popup_opts(title)
  local menu_opts = build_menu_opts(title, menu_items, on_done)
  return popup_opts, menu_opts
end

local function override_ui_select()
  ---@diagnostic disable-next-line: undefined-field
  local UISelect = nmenu:extend("UISelect")

  function UISelect:init(items, opts, on_done)
    local popup_options, menu_options = buildOptions(items, opts, on_done)

    UISelect.super.init(self, popup_options, menu_options)
    self:on(event.BufLeave, function()
      on_done(nil, nil)
    end, { once = true })
  end

  local select_ui = nil

  vim.ui.select = function(items, opts, on_choice)
    assert(type(on_choice) == 'function', 'missing on_choice function')
    if select_ui then
      vim.api.nvim_err_writeln('busy: another select is pending!')
      return
    end
    select_ui = UISelect(items, opts, function(item, index)
      if select_ui then
        select_ui:unmount()
      end
      on_choice(item, index)
      select_ui = nil
    end)
    select_ui:mount()
  end
end

override_ui_select()
