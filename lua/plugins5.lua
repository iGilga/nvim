local u = require('utils')

return {
  {
    'wbthomason/packer.nvim',
    'lewis6991/impatient.nvim',
    'nvim-lua/plenary.nvim',
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('theme.kanagawa').init()
    end,
  },
  -- notify
  {
    'rcarriga/nvim-notify',
    config = function()
      require('utils.logger')
    end,
  },
  -- mason
  {
    'williamboman/mason.nvim',
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonLog',
    },
    config = function()
      require('plugins.mason')
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'b0o/SchemaStore.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      require('plugins.lsp')
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = {
      { 'jayp0521/mason-null-ls.nvim' },
    },
    config = function()
      require('plugins.null-ls')
    end,
    enable = false,
  },
  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      -- 'windwp/nvim-ts-autoversion',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        'm-demare/hlargs.nvim',
        config = function()
          require('hlargs').setup({
            -- color = '#C8C093'
          })
        end,
        enable = false,
      },
    },
    build = ':TSUpdate',
    event = 'BufReadPost',
    cmd = 'TSUpdate',
    config = function()
      require('plugins.treesitter')
    end,
  },
  -- finder file, code, etc
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'kdheepak/lazygit.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'rcarriga/nvim-notify',
    },
    cmd = 'Telescope',
    config = function()
      require('plugins.telescope')
    end,
  },
  -- telescope-zettel
  -- {
  --   'https://gitlab.com/thlamb/telescope-zettel.nvim',
  --   dependencies = {
  --     { 'nvim-telescope/telescope.nvim' },
  --     { 'nvim-lua/plenary.nvim' },
  --   },
  --   config = function()
  --     require('telescope').setup({
  --       extensions = {
  --         zettel = {
  --           zk_path = '~/Documents/Zettel',
  --           link_style = 'md', -- or "md"
  --           remove_ext = false, -- or false
  --         },
  --       },
  --     })
  --     require('telescope').load_extension('zettel')
  --   end,
  -- },
  -- bufferline
  {
    'akinsho/bufferline.nvim',
    event = 'BufAdd',
    -- event = 'bufReadPre',
    version = 'v2.*',
    config = function()
      require('plugins.bufferline')
    end,
  },

  {
    'antoinemadec/FixCursorHold.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },
  --bottomline
  {
    'hoob3rt/lualine.nvim',
    lazy = false,
    config = function()
      require('plugins.lualine')
    end,
  },
  -- tabout.nvim
  {
    'abecodes/tabout.nvim',
    dependencies = {
      'nvim-treesitter',
      'nvim-cmp',
    },
    config = function()
      require('plugins.tabout')
    end,
  },
  -- autocomplete
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('plugins.luasnip')
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'onsails/lspkind-nvim' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-cmdline' },
      {
        'windwp/nvim-autopairs',
        config = function()
          require('plugins.autopairs')
        end,
      },
    },
    config = function()
      require('plugins.cmp')
    end,
  },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     { 'onsails/lspkind-nvim' },
  --     {
  --       'L3MON4D3/LuaSnip',
  --       config = function()
  --         require('plugins.luasnip')
  --       end,
  --     },
  --   },
  --   { 'rafamadriz/friendly-snippets' },
  --   { 'hrsh7th/cmp-nvim-lsp' },
  --   { 'saadparwaiz1/cmp_luasnip' },
  --   { 'hrsh7th/cmp-buffer' },
  --   { 'hrsh7th/cmp-nvim-lua' },
  --   { 'hrsh7th/cmp-path' },
  --   { 'hrsh7th/cmp-cmdline' },
  --   config = function()
  --     require('plugins.cmp')
  --   end,
  -- },
  -- {
  --   'ray-x/lsp_signature.nvim',
  --   config = function(config)
  --     require('lsp_signature').setup({
  --       bind = true,
  --       handler_opts = {
  --         border = config.style,
  --       },
  --     })
  --   end,
  --   enable = false,
  -- },
  -- aka easymotion
  {
    'phaazon/hop.nvim',
    name = 'hop',
    config = function()
      require('hop').setup({
        -- create_hl_autocmd = false,
      })
    end,
  },

  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  -- file manager
  {
    'luukvbaal/nnn.nvim',
    cmd = 'NnnPicker',
    config = function()
      require('nnn').setup({
        explorer = { session = 'local' },
        picker = {
          session = 'local',
          style = { border = 'solid' },
        },
      })
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = {
      'NvimTreeClose',
      'NvimTreeFocus',
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('plugins.nvimtree')
    end,
  },
  -- find project for telescope
  -- {
  --   'ahmedkhalf/project.nvim',
  --   config = function()
  --     require('project_nvim').setup({})
  --   end,
  -- },
  -- comment
  {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  -- indentline
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = function()
      require('plugins.indentblankline')
    end,
  },
  -- git column signs
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    event = 'BufRead',
    config = function()
      require('plugins.gitsigns')
    end,
  },
  -- show keybinds
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({
        disable = { filetype = { 'TelescopePromt', 'nvim-tree' } },
      })
    end,
  },
  -- show colors
  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('plugins.colorizer')
    end,
  },

  {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      local setup = {
        -- size = 10,
        open_mapping = [[<a-n>]],
        shading_factor = 2,
        direction = 'horizontal',
        float_opts = {
          border = 'single',
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      }
      require('toggleterm').setup(setup)
    end,
  },
  {
    'ThePrimeagen/harpoon',
    config = function()
      require('harpoon').setup()
    end,
  },
  {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup({})
    end,
  },
  -- dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    -- lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('plugins.alpha')
    end,
  },
  -- session
  {
    'Shatur/neovim-session-manager',
    cmd = 'SessionManager',
    event = 'BufWritePost',
    config = function()
      require('plugins.sessionmanager')
    end,
  },
  {
    'yamatsum/nvim-cursorline',
    enable = u.isDisable('nvim-cursorline'),
  },
  { 'MunifTanjim/nui.nvim' },
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },
  {
    'LudoPinelli/comment-box.nvim',
    config = function()
      require('plugins.comment-box')
    end,
  },
  -- Manage git
  { 'kdheepak/lazygit.nvim' },
  -- markdown
  { 'ellisonleao/glow.nvim', branch = 'main' },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    enable = false,
  },
  {
    'sQVe/sort.nvim',
    config = function()
      require('sort').setup({})
    end,
  },
  {
    'monaqa/dial.nvim',
    config = function()
      require('plugins.dial')
    end,
  },
  {
    'nvim-neorg/neorg',
    config = function()
      require('neorg').setup({
        ['core.defaults'] = {},
        ['core.norg.dirman'] = {
          config = {
            workspaces = {
              work = '~/notes/work',
              home = '~/notes/home',
            },
          },
        },
      })
    end,
    dependencies = 'nvim-lua/plenary.nvim',
  },
  {
    'mickael-menu/zk-nvim',
    config = function()
      require('zk').setup({
        picker = 'select',
        lsp = {
          cmd = { 'zk', 'lsp' },
          name = 'zk',
        },

        auto_attach = { enabled = true, filetype = { 'markdown' } },
      })
    end,
  },
}
