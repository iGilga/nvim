local highlights = function()
  local c = {
    dark = '#16161D',
    normal = '#1f1f28',
    oldWhite = '#c8c093',
    gray = '#727169',
    green = '#76946a',
    yellow = '#dca561',
    red = '#c34443',
    peachRed = '#FF5D62'
  }
  return {
    fill = { bg = c.dark },
    background = { fg = c.gray, bg = c.dark },
    buffer_selected = { fg = c.oldWhite, bg = c.normal, bold = true },
    buffer_visible = { fg = c.oldWhite, bg = c.normal },
    duplicate = { fg = c.gray, bg = c.dark, italic = false },
    duplicate_selected = { fg = c.gray, bg = c.normal, bold = true },
    duplicate_visible = { fg = c.oldWhite, bg = c.dark },
    indicator_selected = { bg = c.normal, fg = c.oldWhite },
    indicator_visible = { bg = c.normal },
    modified = { fg = c.yellow, bg = c.dark },
    modified_selected = { fg = c.yellow, bg = c.normal, },
    modified_visible = { fg = c.yellow, bg = c.normal, },
    separator = { fg = c.normal, bg = c.dark },
    separator_selected = { fg = c.normal, bg = c.dark },
    separator_visible = { fg = c.normal, bg = c.dark },
    pick = { fg = c.peachRed, bg = c.dark, bold = true },
    pick_selected = { fg = c.peachRed, bg = c.normal, bold = true, },
    pick_visible = { fg = c.peachRed, bg = c.normal, bold = true, },
    trunc_marker = { bg = c.dark }
  }
end

local setup = {
  options = {
    always_show_bufferline  = false,
    separator_style         = { '', '' },
    indicator               = { icon = '|', },
    left_trunc_marker       = '<',
    right_trunc_marker      = '>',
    show_buffer_close_icons = false,
    show_tab_indicators     = false,
    show_close_icon         = false,
    max_name_length         = 20,
    max_prefix_length       = 10,
    tab_size                = 16,
  },
  highlights = highlights()
}

local keys = function()
  local bl = require('bufferline')
  return {
    { 'tt',    ':BufferLinePick<cr>',      desc = '[bufferline]Pick buffer' },
    { '<a-k>', ':BufferLineCycleNext<cr>', desc = '[bufferline]Next buffer' },
    { '<a-j>', ':BufferLineCyclePrev<cr>', desc = '[bufferline]Prev buffer' },
    { 'ts',    ':BufferLinePickClose<cr>', desc = '[bufferline]Close picked buffer' },
    { 'tss',   ':bdelete<cr>',             desc = '[bufferline]Close current buffer' },
    {
      'tn',
      function()
        bl.sort_by(function(buf_a, buf_b)
          return buf_a.id < buf_b.id
        end)
      end,
      desc = '[bufferline]Sorting buffer number',
    },
    { 'td', function() bl.sort_by('directory') end, desc = '[bufferline]Sorting buffer directory', },
    { 'te', function() bl.sort_by('extension') end, desc = '[bufferline]Sorting buffer language', },
  }
end

return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'BufAdd',
  version = '*',
  keys = keys,
  opts = setup,
}
