local setup = {
  options = {
    offsets = {
      { filetype = 'NvimTree', text = '', padding = 1 },
    },
    always_show_bufferline = false,
    separator_style = { '', '' },
    show_buffer_close_icons = false,
    show_tab_indicators = false,
    show_close_icon = false,
    max_name_length = 20,
    max_prefix_length = 10,
    tab_size = 16,
  },
}

local keys = {
  { 'tt', ':BufferLinePick<cr>', desc = '[bufferline]Pick buffer' },
  { '<a-k>', ':BufferLineCycleNext<cr>', desc = '[bufferline]Next buffer' },
  { '<a-j>', ':BufferLineCyclePrev<cr>', desc = '[bufferline]Prev buffer' },
  -- close buffer
  { 'ts', ':BufferLinePickClose<cr>', desc = '[bufferline]Close buffer' },
  { 'tss', ':bdelete<cr>', desc = '[bufferline]Close buffer' },
  -- sorting
  {
    'tn',
    function()
      require('bufferline').sort_buffers_by(function(buf_a, buf_b)
        return buf_a.id < buf_b.id
      end)
    end,
    desc = '[bufferline]Sort buffer number',
  },

  {
    'td',
    function()
      require('bufferline').sort_buffers_by('directory')
    end,
    desc = '[bufferline]Sort buffer directory',
  },

  {
    'te',
    function()
      require('bufferline').sort_buffers_by('extension')
    end,
    desc = '[bufferline]Sort buffer language',
  },
}

return {
  'akinsho/bufferline.nvim',
  event = 'BufAdd',
  version = 'v2.*',
  keys = keys,
  config = setup,
}
