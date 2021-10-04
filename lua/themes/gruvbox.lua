local use = require("packer").use
use "eddyekofo94/gruvbox-flat.nvim"
vim.cmd("colorscheme gruvbox-flat")
require("lualine").setup {
  options = {
    theme = "gruvbox-flat"
  },
  extensions = {"nvim-tree"}
}
