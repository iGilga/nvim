local present, pluginPacker = pcall(require, 'plugins.packer')

if not present then
  return false
end

local packer = pluginPacker.packer

local config = {
  theme = 'kanagawa',
}

return packer.startup({
  function(use)
    use({
      'wbthomason/packer.nvim',
      'lewis6991/impatient.nvim',
      'nathom/filetype.nvim',
      'nvim-lua/plenary.nvim',
    })

    -- load theme
    require('themes.plugins').init(use, config)

    -- lsp-config
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('plugins.lsp')
      end,
      requires = {
        { 'williamboman/nvim-lsp-installer' },
        {
          'jose-elias-alvarez/null-ls.nvim',
          config = function()
            require('plugins.null-ls')
          end,
          after = 'nvim-lspconfig',
        },
      },
    })

    -- syntax code
    use({
      {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
          require('plugins.treesitter')
        end,
      },
      { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
      { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
    })

    -- finder file, code, etc
    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      },
      config = function()
        require('plugins.telescope')
      end,
    })

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
        require('lualine').setup({
          options = {
            disabled_filetypes = { 'NnnExplorer', 'NnnPicker' },
            sections = { lualine_c = { require('auto-session-library').current_session_name } },
          },
        })
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
          picker = { session = 'local' },
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

    -- indentline
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup({
          char_list = { '|', '¦', '┆', '┊' },
          show_current_context = true,
          space_char_blankline = ' ',
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

    if pluginPacker.first_install then
      packer.sync()
    end
  end,
})
