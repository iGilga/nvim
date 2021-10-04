local use = require("packer").use
use "folke/tokyonight.nvim"

require("lualine").setup {
  options = {
    theme = "tokyonight"
  },
  extensions = {"nvim-tree"}
}

vim.cmd[[colorscheme tokyonight]]
