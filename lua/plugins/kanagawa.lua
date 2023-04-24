local function setup()
  C = require('theme.colors')

  local highlights = {}

  for _, module in ipairs({ 'base' }) do
    highlights = vim.tbl_deep_extend('force', highlights, require('theme.' .. module))
  end

  for plugin, enabled in pairs({
    gitsigns = false,
    alpha = true,
    bufferline = true,
    cmp = true,
    hop = true,
    nnn = true,
    notify = true,
    nui = true,
    telescope = true,
    todo = true,
    illuminate = true,
    marks = true,
  }) do
    if enabled then
      highlights = vim.tbl_deep_extend('force', highlights, require('theme.plugins.' .. plugin))
    end
  end

  local setup = {
    globalStatus = true,
    overrides = function ()
      return highlights
    end,
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none"
          }
        }
      }
    },
    theme = 'wave',
  }
  local kanagawa = require('kanagawa')
  kanagawa.setup(setup)
  vim.api.nvim_command('colorscheme kanagawa')
  -- kanagawa.load("wave")
  -- vim.api.nvim_command(('colorscheme %s'):format(name))
end

return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  cmd = 'KanagawaCompile',
  -- build = 'KanagawaCompile',
  config = setup,
}
