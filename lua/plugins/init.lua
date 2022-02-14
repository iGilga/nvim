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
        {
          'williamboman/nvim-lsp-installer',
          config = function()
            local lspinstaller = require('nvim-lsp-installer')
            lspinstaller.settings({
              ui = {
                icons = {
                  server_installed = '✓',
                  server_pending = '➜',
                  server_uninstalled = '✗',
                },
              },
            })
          end,
        },
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
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'windwp/nvim-ts-autotag',
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
        -- { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        'natecraddock/telescope-zf-native.nvim',
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
        require('lualine').setup({
          options = {
            disabled_filetypes = { 'NnnExplorer', 'NnnPicker' },
          },
          sections = {
            -- lualine_c = {
            -- },
            lualine_x = {
              { require('auto-session-library').current_session_name },
              'encoding',
              'fileformat',
              'filetype',
            },
          },
          extensions = { 'fzf' },
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
          picker = { style = { border = 'rounded' }, session = 'local' },
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

    use({
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('trouble').setup({})
        vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>Trouble<cr>', { silent = true, noremap = true })
        vim.api.nvim_set_keymap(
          'n',
          '<leader>xw',
          '<cmd>Trouble workspace_diagnostics<cr>',
          { silent = true, noremap = true }
        )
        vim.api.nvim_set_keymap(
          'n',
          '<leader>xd',
          '<cmd>Trouble document_diagnostics<cr>',
          { silent = true, noremap = true }
        )
        vim.api.nvim_set_keymap('n', '<leader>xl', '<cmd>Trouble loclist<cr>', { silent = true, noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', { silent = true, noremap = true })
        vim.api.nvim_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<cr>', { silent = true, noremap = true })
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
          buftype_exclude = { 'terminal', 'prompt', 'nofile', 'help' },
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
        require('twilight').setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        })
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
      disable = true,
    })

    use({
      'tami5/lspsaga.nvim',
      config = function()
        local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
        require('lspsaga').setup({
          error_sign = signs.Error,
          warn_sign = signs.Warn,
          hint_sign = signs.Hint,
          infor_sign = signs.Info,
        })
      end,
      disable = true,
    })

    use('rcarriga/nvim-notify')

    use('MunifTanjim/nui.nvim')

    use({
      'max397574/better-escape.nvim',
      config = function()
        require('better_escape').setup()
      end,
      disable = true,
    })

    use({
      'LudoPinelli/comment-box.nvim',
      config = function()
        local keymap = vim.api.nvim_set_keymap

        keymap('n', '<Leader>cl', "<Cmd>lua require('comment-box').lbox()<CR>", {})
        keymap('v', '<Leader>cl', "<Cmd>lua require('comment-box').lbox()<CR>", {})

        keymap('n', '<Leader>cc', "<Cmd>lua require('comment-box').cbox()<CR>", {})
        keymap('v', '<Leader>cc', "<Cmd>lua require('comment-box').cbox()<CR>", {})

        keymap('n', '<Leader>ci', "<Cmd>lua require('comment-box').line()<CR>", {})
        keymap('i', '<-l>', "<Cmd>lua require('comment-box').line()<CR>", {})
      end,
    })
    if pluginPacker.first_install then
      packer.sync()
    end
  end,
})
