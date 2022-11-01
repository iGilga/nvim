local config = require('config').plugins.treesitter
local setup = {
  ensure_installed = config.ensure_installed,
  highlight = {
    enable = true,
    -- use_languagetree = true,
    additional_vim_regex_highlighting = { 'markdown' },
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
    navigation = {
      enable = true,
    },
  },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    additional_vim_regex_highlighting = false,
  },
}

require('nvim-treesitter.configs').setup(setup)
