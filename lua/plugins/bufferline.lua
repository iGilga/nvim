local setup = {
  options = {
    offsets = {
      { filetype = 'NvimTree', text = '', padding = 1 },
      { filetype = 'neo-tree', text = '', padding = 1 },
      { filetype = 'Outline', text = '', padding = 1 },
    },
    separator_style = 'thin',
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
}

require('bufferline').setup(setup)
