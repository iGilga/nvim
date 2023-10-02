local setup = {
  indent = {
    -- char = { '|', '¦', '┆', '┊' },
  },
  exclude = {
    filetypes = {
      'alpha',
      'checkhealth',
      'dashboard',
      'gitcommit',
      'help',
      'help',
      'lazy',
      'lspinfo',
      'man',
      'markdown',
      'packer',
      'norg',
      '',
    },
  },
  scope = {
    enabled = true,
    show_start = true,
  },
}

return {
  'lukas-reineke/indent-blankline.nvim',
  name = 'ibl',
  event = 'BufReadPre',
  opts = setup,
}
