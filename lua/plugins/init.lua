--vim.cmd [[packadd packer.nvim]]
local present, packer = pcall(require, 'packer')

if not present then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

	print('Cloning packer...')
	vim.fn.delete(install_path, 'rf')
	vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd('packadd packer.nvim')
  present, packer = pcall(require, 'packer')

  if present then
		print('packer.nvim cloned successfully.')
  else
    error('Cant clone packer.nvim')
  end
end

return require("packer").startup({
  function(use)
     -- packer.nvim
    use ({
      'wbthomason/packer.nvim',
      'lewis6991/impatient.nvim',
      'nathom/filetype.nvim',
      'nvim-lua/plenary.nvim',
    })

     -- lsp-config
    use {
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/nvim-lsp-installer"
      },
    }

    -- syntax code
    use({
      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
          require("plugins.treesitter")
        end
      },
      { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
      { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
    })

    -- finder file, code, etc
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
      },
      config = function()
        require("plugins.telescope")
      end
    }

    -- topline
    use {
      "romgrk/barbar.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true }
    }

    --bottomline
    use {
      "hoob3rt/lualine.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require('lualine').setup {
          options = { disabled_filetypes = {'NnnExplorer', 'NnnPicker'} }
        }
      end
    }

     -- autocomplete
    use ({
      'hrsh7th/nvim-cmp',
      config = function()
        require('plugins.cmp')
      end,
      requires = {
        { 'onsails/lspkind-nvim' },
        { 'L3MON4D3/LuaSnip',
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
        { 'windwp/nvim-autopairs',
          config = function()
            require('plugins.autopairs')
          end,
          after = 'nvim-cmp',
        },
      },
    })
      
    -- aka easymotion
    use {
      "phaazon/hop.nvim",
      as = "hop",
      config = function()
        require "hop".setup {}
    end
    }

    -- file manager
    use {
      "luukvbaal/nnn.nvim",
      config = function()
        require("nnn").setup {
          explorer = { session = "local" },
          picker = { session = "local" },
        }
      end
    }

    -- find project for telescope
    use {
      'ahmedkhalf/project.nvim',
      config = function()
        require('project_nvim').setup {}
      end
    }

    -- comment
    use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
    }

    -- indentline
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup {
          char_list = {'|', '¦', '┆', '┊'},
          show_current_context = true,
          space_char_blankline = ' ',
          filetype_exclude = {'help', 'NnnExplorer', 'NnnPicker'}
        }
      end
    }

    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup { }
      end
    }
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})
