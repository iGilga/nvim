return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local setup = {
        globalStatus = true,
      }
      local kanagawa = require('kanagawa')
      kanagawa.setup(setup)
      vim.api.nvim_command('colorscheme kanagawa')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    cmd = 'TSUpdate',
    opts = {
      ensure_installed = {
        'lua',
      },
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      require('treesitter-context').setup({})
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'kdheepak/lazygit.nvim' },
      { 'rcarriga/nvim-notify' },
      {
        'phaazon/hop.nvim',
        name = 'hop',
        config = function()
          require('hop').setup({
            -- create_hl_autocmd = false,
          })
        end,
      },
    },
    cmd = 'Telescope',
    keys = {
      {
        '<leader>ff',
        "<cmd>lua require('telescope.builtin').find_files()<cr>",
        { desc = 'search files' },
      },
    },
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  require('plugins.indentblankline'),
}
