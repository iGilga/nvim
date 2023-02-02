local setup = {
  ensure_installed = {
    'bash',
    'c',
    'c_sharp',
    'cpp',
    'css',
    'dockerfile',
    'help',
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
    'rust',
    'scss',
    'toml',
    'yaml',
  },
  highlight = {
    enable = true,
    -- use_languagetree = true,
    additional_vim_regex_highlighting = { 'markdown' },
  },
  autopairs = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s',
      },
      javascriptreact = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s',
      },
      typescript = { __default = '// %s', __multiline = '/* %s */' },
    },
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

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    -- 'windwp/nvim-ts-autoversion',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
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
