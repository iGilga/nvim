vim.o.background = 'dark'
vim.o.termguicolors = true

C = require('theme.colors')

local highlights = {}

for _, module in ipairs({ 'base' }) do
  highlights = vim.tbl_deep_extend('force', highlights, require('theme.' .. module))
end

for plugin, enabled in pairs({
  alpha = true,
  bufferline = true,
  cmp = true,
  -- gitsigns = true,
  nnn = true,
  notify = true,
  nui = true,
  telescope = true,
  todo = true,
}) do
  if enabled then
    highlights = vim.tbl_deep_extend('force', highlights, require('theme.plugins.' .. plugin))
  end
end

local M = {}

function M.setup(name)
  local setup = {
    globalStatus = true,
    overrides = highlights,
  }
  local kanagawa = require('kanagawa')
  kanagawa.setup(setup)
  vim.api.nvim_command(('colorscheme %s'):format(name))
end

return M

-- ["neo-tree"] = true,
-- ["nvim-tree"] = false,
-- ["nvim-web-devicons"] = true,
-- ["which-key"] = true,
-- aerial = true,
-- beacon = false,
-- highlighturl = true,
-- hop = false,
-- indent_blankline = true,
-- lightspeed = false,
-- rainbow = true,
-- symbols_outline = false,
-- vimwiki = false,
