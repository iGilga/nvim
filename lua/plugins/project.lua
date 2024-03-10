return {
  'ahmedkhalf/project.nvim',
  event = 'VimEnter',
  opts = {
    exclude_dirs = { '~/Downloads', '~/Desktop' },
    ignore_lsp = {},
    silent_chdir = false,
  },
  config = function(_, opts)
    require('project_nvim').setup(opts)
  end,
  enabled = false,
}
