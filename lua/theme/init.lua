local M = {}

function M.init(use, config)
  use({
    'rebelot/kanagawa.nvim',
    as = config.theme,
    config = function(name)
      require('theme.kanagawa').setup(name)
    end,
    disable = config.theme ~= 'kanagawa',
  })

  -- use({
  --   'folke/tokyonight.nvim',
  --   as = 'tokyonight',
  --   config = function()
  --     vim.g.tokyonight_style = 'night'
  --     -- load(config.theme)
  --   end,
  --   disable = theme.theme ~= 'tokyonight',
  -- })
 --
  -- use({
  --   'ellisonleao/gruvbox.nvim',
  --   as = 'gruvbox',
  --   requires = { 'rktjmp/lush.nvim' },
  --   config = function()
  --     vim.o.background = 'dark'
  --     -- load(config.theme)
  --   end,
  --   disable = theme.theme ~= 'gruvbox',
  -- })
  --
  -- use({
  --   'EdenEast/nightfox.nvim',
  --   as = 'nightfox',
  --   config = function()
  --     -- load(config.theme)
  --   end,
  --   disable = theme.theme ~= 'nightfox',
  -- })
end

return M
