local setup = {
  options = {
    offsets = {
      { filetype = 'NvimTree', text = '', padding = 1 },
    },
    separator_style = { '', '' },
    show_buffer_close_icons = false,
    show_tab_indicators = false,
    show_close_icon = false,
    max_name_length = 14,
    max_prefix_length = 8,
    tab_size = 16,
  },
}

require('bufferline').setup(setup)
