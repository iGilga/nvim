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
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
      },
      config = function()
        require("plugins.telescope")
      end
    }

    use {
      "windwp/nvim-autopairs",
      config = function()
        require("plugins.autopairs")
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
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = require("indent_blankline").setup {
        char_list = {"|", "¦", "┆", "┊"},
        show_current_context = true,
        space_char_blankline = " ",
        filetype_exclude = {"help", "dashboard", "NvimTree"}
      }
    }
    use {
      "rmagatti/session-lens",
      requires = {"rmagatti/auto-session", "nvim-telescope/telescope.nvim"},
      config = function()
        require("session-lens").setup({})
      end
    }
  end
)
