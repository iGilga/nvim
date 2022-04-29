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
      'nathom/filetype.nvim',
      'nvim-lua/plenary.nvim',
    })

    -- load theme
    require('theme.plugins').init(use, config)

    use({
      'rcarriga/nvim-notify',
      config = function()
        require('utils.logger').init()
      end,
    })

    -- lsp-config
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('lsp')
      end,
      requires = {
        { 'b0o/SchemaStore.nvim' },
        { 'williamboman/nvim-lsp-installer' },
        { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
        {
          'jose-elias-alvarez/null-ls.nvim',
          config = function()
            require('plugins.null-ls')
          end,
          after = 'nvim-lspconfig',
          disable = false,
        },
      },
      event = 'BufWinEnter',
    })
    -- syntax code
    use({
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'windwp/nvim-ts-autotag',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-refactor',
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
        'natecraddock/telescope-zf-native.nvim',
        { 'kdheepak/lazygit.nvim' },
      },
      config = function()
        require('plugins.telescope')
      end,
    })

    -- telescope with hop
    use({ 'nvim-telescope/telescope-hop.nvim' })

    -- topline
    use({
      'romgrk/barbar.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    })

    --bottomline
    use({
      'hoob3rt/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('plugins.lualine')
      end,
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

    -- aka easymotion
    use({
      'phaazon/hop.nvim',
      as = 'hop',
      config = function()
        require('hop').setup({})
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
          },
        })
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
      config = function()
        require('Comment').setup()
      end,
    })

    use({
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('plugins.todocomments')
      end,
    })

    -- indentline
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup({
          char_list = { '|', '¦', '┆', '┊' },
          show_current_context = true,
          space_char_blankline = ' ',
          buftype_exclude = { 'terminal', 'prompt', 'nofile' },
          filetype_exclude = { 'help', 'packer', 'lspinfo', 'dashboard', 'NnnExplorer', 'NnnPicker' },
        })
      end,
    })

    -- git column signs
    use({
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      opt = true,
      event = 'BufRead',
      config = function()
        require('gitsigns').setup()
      end,
    })

    -- show keybinds
    use({
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup({})
      end,
    })

    -- show colors
    use({
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('plugins.colorizer')
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
      'glepnir/dashboard-nvim',
      config = function()
        require('plugins.dashboard')
      end,
      -- disable = true,
    })

    -- auto-session
    use({
      'rmagatti/auto-session',
      config = function()
        require('plugins.autosession')
      end,
    })

    use({
      'rmagatti/session-lens',
      requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
      config = function()
        require('plugins.sessionlens')
      end,
    })

    use({
      'yamatsum/nvim-cursorline',
      disable = u.isDisable('nvim-cursorline'),
    })

    use('MunifTanjim/nui.nvim')

    use({
      'max397574/better-escape.nvim',
      config = function()
        require('better_escape').setup()
      end,
      disable = u.isDisable('better-escape.nvim'),
    })

    use({
      'LudoPinelli/comment-box.nvim',
      config = function()
        require('plugins.comment-box')
      end,
    })

    use('kdheepak/lazygit.nvim')

    if pluginPacker.first_install then
      packer.sync()
    end
  end,
})
