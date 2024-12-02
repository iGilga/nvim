local setup = {
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'c_sharp',
    'css',
    'dockerfile',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'norg',
    'python',
    'rasi',
    'regex',
    'rust',
    'scss',
    'toml',
    'tsx',
    'yaml',
    'hyprlang',
  },
  highlight = {
    enable = true,
    -- use_languagetree = true,
    additional_vim_regex_highlighting = { 'markdown' },
  },
  autopairs = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
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
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aa'] = '@assignment.outer',
        ['ia'] = '@assignment.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ap'] = '@parameter.outer',
        ['ip'] = '@parameter.inner',
        ['ah'] = '@call.outer',
        ['ih'] = '@call.inner',
      },
    },
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
    -- auto_install = false,
    -- sync_install = false,
  },
}

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    -- 'windwp/nvim-ts-autoversion',
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'luckasRanarison/tree-sitter-hyprlang',
    {
      'm-demare/hlargs.nvim',
      config = function()
        require('hlargs').setup({
          -- color = '#C8C093'
        })
      end,
      enabled = false,
    },
  },
  build = ':TSUpdate',
  event = 'BufReadPost',
  cmd = 'TSUpdate',
  opts = setup,
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    require('treesitter-context').setup({})
  end,
}
