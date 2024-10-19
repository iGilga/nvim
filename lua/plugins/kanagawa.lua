local function config()
  local setup = {
    globalStatus = true,
    overrides = require('theme.highlights'),
    colors = require('theme.colors'),
    theme = 'wave',
  }

  require('kanagawa').setup(setup)
  vim.api.nvim_command('colorscheme kanagawa')
end

return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    cmd = 'KanagawaCompile',
    config = config,
  },
  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      color_icons = false
    }
  }
}
