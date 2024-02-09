local M = {}

local nmenu = require('nui.menu')
local ntext = require('nui.text')
local nline = require('nui.line')
local event = require('nui.utils.autocmd').event

local config = {
  min_width = 80,
  border = {
    bottom_hl = 'NuiBottom',
    highlight = 'NuiBorder',
    style = 'solid',
  },
  title = {
    title_align = 'center',
    highlight = 'NuiTitle',
  },
  separator = {
    char = ' ',
    text_align = 'center',
    highlight = 'NuiSeparator',
  },
  highlight = 'Normal:NuiNormal',
}

local function get_prompt_text(prompt, default_prompt)
  local prompt_text = prompt or default_prompt
  if prompt_text:sub(-1) == ":" then
    prompt_text = "[" .. prompt_text:sub(1, -2) .. "]"
  end
  return prompt_text
end

local function override_ui_select()
  ---@diagnostic disable-next-line: undefined-field
  local UISelect = nmenu:extend("UISelect")

  function UISelect:init(items, opts, on_done)
    local border_top_text = get_prompt_text(opts.prompt, "[Select item]")
    local kind = opts.kind or 'unknown'
    local format_item = nil
    if opts.prompt == 'Load Session' then
      format_item = function(item)
        local path = item.dir.filename
        local dir = ntext((vim.fs.dirname(path):gsub('/home/stag', '~')) .. '/', config.border.bottom_hl)
        local basename = ntext(vim.fs.basename(path), 'NuiText')
        return nline({ dir, basename })
      end
    else
      format_item = opts.format_item
    end
    -- local format_item = opts.format_item or function(item)
    --   return tostring(item.__raw_item or item)
    -- end
    local popup_options = {
      relative = 'editor',
      position = '50%',
      highlight = config.highlight,
      border = {
        highlight = config.border.highlight,
        style = config.border.style,
        text = {
          top = ntext(' ' .. border_top_text .. ' ', config.title.highlight),
          top_align = config.title.title_align,
        }
      },
      -- win_options = {
      -- winhighlight = 'NormalFloat:Normal,FloatBorder:Normal',
      -- },
      zindex = 999,
    }

    if kind == 'codeaction' then
      popup_options.relative = 'cursor'
      popup_options.position = {
        row = 1,
        col = 0,
      }
    end

    local max_widht = popup_options.relative == 'editor' and vim.o.columns - 4 or vim.api.nvim_win_get_width(0) - 4
    local max_height = popup_options.relative == 'editor' and math.floor(vim.o.lines * 80 / 100) or
        vim.api.nvim_win_get_height(0)

    local menu_items = {}
    for index, item in ipairs(items) do
      if type(item) ~= 'table' then
        item = { __raw_item = item }
      end
      item.index = index
      menu_items[index] = nmenu.item(format_item(item), item)
    end

    local menu_options = {
      min_width = vim.api.nvim_strwidth(border_top_text) + 40,
      max_widht = max_widht,
      max_height = max_height,
      lines = menu_items,
      on_close = function()
        on_done(nil, nil)
      end,
      on_submit = function(item)
        on_done(item.__raw_item or item, item.index)
      end,
    }
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
