local config = require('config').plugins.treesitter
local setup = {
  ensure_installed = config.ensure_installed,
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = {
      enable = true,
    },
  },
}

require('nvim-treesitter.configs').setup(setup)
