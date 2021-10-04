vim.cmd [[packadd packer.nvim]]

require("packer").startup(
  function(use)
    use({"wbthomason/packer.nvim", opt = true})
    use {
      "neovim/nvim-lsp-config",
      "williamboman/nvim-lsp-installer"
    }
    use {
      "dstein64/vim-startuptime",
      cmd = "StartupTime"
    }
    use(
      {
        {
          "nvim-treesitter/nvim-treesitter",
          run = ":TSUpdate",
          config = function()
            require("plugins.treesitter")
          end
        },
        {
          "nvim-treesitter/nvim-treesitter-textobjects",
          after = "nvim-treesitter"
        },
        {
          "windwp/nvim-ts-autotag",
          after = "nvim-treesitter"
        }
      }
    )
    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      requires = {"ms-jpq/coq.artifacts", branch = "artifacts"}
    }

    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
      }
    }

    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      }
    }
    use {
      "windwp/nvim-autopairs",
      config = function()
        require("plugins.autopairs")
      end
    }
    use {
      "blackCauldron7/surround.nvim",
      config = function()
        require "surround".setup {mappings_style = "sandwich"}
      end
    }
    use {
      "romgrk/barbar.nvim",
      requires = {"kyazdani42/nvim-web-devicons"}
    }
    use {
      "hoob3rt/lualine.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }
    use {
      "phaazon/hop.nvim",
      as = "hop",
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require "hop".setup {}
      end
    }
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.nvimtree")
      end
    }
    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup {}
      end
    }
    use "glepnir/dashboard-nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "mhartington/formatter.nvim"
    use "b3nj5m1n/kommentary"
    use {
      "rmagatti/session-lens",
      requires = {"rmagatti/auto-session", "nvim-telescope/telescope.nvim"},
      config = function()
        require("session-lens").setup({})
      end
    }
  end
)
