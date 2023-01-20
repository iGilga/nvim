local function setup()
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
    -- sync_root_with_cwd = true,
    -- respect_buf_cwd = true,
    -- update_focused_file = {
    --   enable = true,
    --   update_root = true,
    -- },
  }

  require('nvim-tree').setup(setup)
end

return {
  'nvim-tree/nvim-tree.lua',
  cmd = {
    'NvimTreeClose',
    'NvimTreeFocus',
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  config = setup,
}
