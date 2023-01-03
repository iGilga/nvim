local ok, pluginPacker = pcall(require, 'plugins.packer')

if not ok then
  return false
end

local packer = pluginPacker.packer
local config = require('config')
local u = require('utils')

return packer.startup({
  function(use)
    use({
      'wbthomason/packer.nvim',
      'lewis6991/impatient.nvim',
      'nvim-lua/plenary.nvim',
    })
    -- load theme
    require('theme').init(use, config)
    -- notify
    use({
      'rcarriga/nvim-notify',
      config = function()
        require('utils.logger')
      end,
    })
    -- lsp-config
    -- use({
    --   'neovim/nvim-lspconfig',
    --   config = function()
    --     require('lsp')
    --   end,
    --   requires = {
    --     { 'b0o/SchemaStore.nvim' },
    --     { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
    --     {
    --       'jose-elias-alvarez/null-ls.nvim',
    --       config = function()
    --         require('plugins.null-ls')
    --       end,
    --       after = 'nvim-lspconfig',
    --       disable = true,
    --     },
    --   },
    --   disable = true,
    --   event = 'BufWinEnter',
    -- })

    use({
      'williamboman/mason.nvim',
      requires = {

        { 'neovim/nvim-lspconfig' },
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'b0o/SchemaStore.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'jayp0521/mason-null-ls.nvim' },
      },
      config = function()
        require('lsp.mason')
      end,
    })

    -- treesitter
    use({
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'windwp/nvim-ts-autotag',
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
          disable = true,
        },
      },
      run = ':TSUpdate',
      config = function()
        require('plugins.treesitter')
      end,
    })
    -- finder file, code, etc
    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        'kdheepak/lazygit.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-symbols.nvim',
      },
      config = function()
        require('plugins.telescope')
      end,
    })
    -- telescope-zettel
    use({
      'https://gitlab.com/thlamb/telescope-zettel.nvim',
      requires = {
        { 'nvim-telescope/telescope.nvim' },
        { 'nvim-lua/plenary.nvim' },
      },
      config = function()
        require('telescope').setup({
          extensions = {
            zettel = {
              zk_path = '~/Documents/Zettel',
              link_style = 'md', -- or "md"
              remove_ext = false, -- or false
            },
          },
        })
        require('telescope').load_extension('zettel')
      end,
    })
    -- bufferline
    use({
      'akinsho/bufferline.nvim',
      tag = 'v2.*',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('plugins.bufferline')
      end,
    })

    use({
      'antoinemadec/FixCursorHold.nvim',
      event = { 'BufRead', 'BufNewFile' },
      config = function()
        vim.g.cursorhold_updatetime = 100
      end,
    })
    --bottomline
    use({
      'hoob3rt/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('plugins.lualine')
      end,
    })
    -- tabout.nvim
    use({
      'abecodes/tabout.nvim',
      config = function()
        require('plugins.tabout')
      end,
      wants = { 'nvim-treesitter' }, -- or require if not used so far
      after = { 'nvim-cmp' }, -- if a completion plugin is using tabs load it before
    })
    -- autocomplete
    use({
      'hrsh7th/nvim-cmp',
      config = function()
        require('plugins.cmp')
      end,
      requires = {
        { 'onsails/lspkind-nvim' },
        {
          'L3MON4D3/LuaSnip',
          config = function()
            require('plugins.luasnip')
          end,
          requires = {
            'rafamadriz/friendly-snippets',
          },
        },
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        {
          'windwp/nvim-autopairs',
          config = function()
            require('plugins.autopairs')
          end,
          after = 'nvim-cmp',
        },
      },
      event = 'InsertEnter',
    })
    use({
      'ray-x/lsp_signature.nvim',
      config = function(config)
        require('lsp_signature').setup({
          bind = true,
          handler_opts = {
            border = config.style,
          },
        })
      end,
      after = 'nvim-lspconfig',
      disable = true,
    })
    -- aka easymotion
    use({
      'phaazon/hop.nvim',
      as = 'hop',
      config = function()
        require('hop').setup({
          create_hl_autocmd = false,
        })
      end,
    })

    use({
      'kylechui/nvim-surround',
      config = function()
        require('nvim-surround').setup({})
      end,
    })
    -- file manager
    use({
      'luukvbaal/nnn.nvim',
      config = function()
        require('nnn').setup({
          explorer = { session = 'local' },
          picker = {
            session = 'local',
            style = { border = 'solid' },
          },
        })
      end,
    })

    use({
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      config = function()
        require('plugins.nvimtree')
      end,
    })
    -- find project for telescope
    use({
      'ahmedkhalf/project.nvim',
      config = function()
        require('project_nvim').setup({})
      end,
    })
    -- comment
    use({
      'numToStr/Comment.nvim',
      event = 'BufRead',
      config = function()
        require('Comment').setup({
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        })
      end,
    })
    use({
      'folke/todo-comments.nvim',
      event = 'BufRead',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('plugins.todocomments')
      end,
    })
    -- indentline
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('plugins.indentblankline')
      end,
    })
    -- git column signs
    use({
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      opt = true,
      event = 'BufRead',
      config = function()
        require('plugins.gitsigns')
      end,
    })
    -- show keybinds
    use({
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup({
          disable = { filetype = { 'TelescopePromt', 'nvim-tree' } },
        })
      end,
    })
    -- show colors
    use({
      'norcalli/nvim-colorizer.lua',
      event = { 'BufRead', 'BufNewFile' },
      config = function()
        require('plugins.colorizer')
      end,
    })

    use({
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
    })

    use({
      'ThePrimeagen/harpoon',
      config = function()
        require('harpoon').setup()
      end,
    })

    use({
      'folke/twilight.nvim',
      config = function()
        require('twilight').setup({})
      end,
    })
    -- dashboard
    use({
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('plugins.alpha')
      end,
    })
    -- session
    use({
      'Shatur/neovim-session-manager',
      cmd = 'SessionManager',
      event = 'BufWritePost',
      config = function()
        require('plugins.sessionmanager')
      end,
    })

    use({
      'yamatsum/nvim-cursorline',
      disable = u.isDisable('nvim-cursorline'),
    })
    use('MunifTanjim/nui.nvim')
    -- Smooth escaping
    use({
      'max397574/better-escape.nvim',
      config = function()
        require('better_escape').setup()
      end,
    })

    use({
      'LudoPinelli/comment-box.nvim',
      config = function()
        require('plugins.comment-box')
      end,
    })
    -- Manage git
    use('kdheepak/lazygit.nvim')
    -- markdown
    use({ 'ellisonleao/glow.nvim', branch = 'main' })
    use({
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      setup = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end,
      ft = { 'markdown' },
      disable = true,
    })

    use({
      'sQVe/sort.nvim',
      config = function()
        require('sort').setup({})
      end,
    })

    use({
      'monaqa/dial.nvim',
      config = function()
        require('plugins.dial')
      end,
    })

    use({
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
      requires = 'nvim-lua/plenary.nvim',
    })

    use({
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
    })
    -- mini.nvim
    use('echasnovski/mini.align')

    if pluginPacker.first_install then
      packer.sync()
    end
  end,
})
