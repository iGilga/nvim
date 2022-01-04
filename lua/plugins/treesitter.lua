local setup = {
  ensure_installed = 'maintained',
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
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = { smart_rename = 'grr' },
    },
  },
}

require('nvim-treesitter.configs').setup(setup)
