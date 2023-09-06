local setup = {
  char_list = { '|', '¦', '┆', '┊' },
  show_current_context = true,
  -- show_current_context_start = true,
  space_char_blankline = ' ',
  buftype_exclude = {
    'nofile',
    'prompt',
    'terminal',
  },
  filetype_exclude = {
    'NnnExplorer',
    'NnnPicker',
    'NvimTree',
    'alpha',
    'dashboard',
    'help',
    'lazy',
    'lspinfo',
    'markdown',
    'packer',
  },
}

return {
  'lukas-reineke/indent-blankline.nvim',
  name = 'ibl',
  event = 'BufReadPre',
  init = function()
    vim.g.indent_blankline_show_trailing_blankline_indent = false
  end,
  opts = setup,
}
