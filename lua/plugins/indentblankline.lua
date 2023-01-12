local setup = {
  char_list = { '|', '¦', '┆', '┊' },
  show_current_context = true,
  -- show_current_context_start = true,
  -- space_char_blankline = ' ',
  buftype_exclude = {
    'terminal',
    'prompt',
    'nofile',
  },
  filetype_exclude = {
    'help',
    'packer',
    'lspinfo',
    'alpha',
    'NnnExplorer',
    'NnnPicker',
    'markdown',
    'lazy',
    'dashboard',
  },
}

require('indent_blankline').setup(setup)
