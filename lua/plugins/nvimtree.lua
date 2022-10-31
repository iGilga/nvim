local setup = {
  view = {
    hide_root_folder = true,
    signcolumn = 'no',
  },
  filters = {
    dotfiles = true,
  },
  renderer = {
    group_empty = true,
  },
  actions = {
    expand_all = {
      exclude = { '.git', 'build', 'dist', 'public' },
    },
  },
}

require('nvim-tree').setup(setup)
