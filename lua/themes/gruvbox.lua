local use = require('packer').use
use 'eddyekofo94/gruvbox-flat.nvim'
vim.cmd('colorscheme gruvbox-flat')
--local gruvbox = require('gruvbox-flat')
--gruvbox.load()
require('lualine').setup {
  options = {
    theme = 'gruvbox-flat'
  }
}
--vim.g.gruvbox_flat_style = 'dark'
