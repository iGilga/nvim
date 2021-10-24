vim.cmd [[packadd packer.nvim]]

require("packer").startup(
  function(use)
    use({"wbthomason/packer.nvim", opt = true})
    use {
      "neovim/nvim-lsp-config",
      requires = {
        "williamboman/nvim-lsp-installer"
      }
    }
    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      requires = {"ms-jpq/coq.artifacts", branch = "artifacts"}
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
      requires = {"kyazdani42/nvim-web-devicons", opt = true},
      config = function()
        require('lualine').setup {
                 options = {disabled_filetypes = {'NnnExplorer'}}
        }
               end
    }
    use {
      "phaazon/hop.nvim",
      as = "hop",
      config = function()
        require "hop".setup {}
      end
    }
    use {
      "luukvbaal/nnn.nvim",
      config = function()
        require("nnn").setup {
          explorer = {
            session = "local"
          },
          picker = {
            session = "local"
          }
        }
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
        filetype_exclude = {"help", "dashboard", "NvimTree", "NnnExplorer", "NnnPicker"}
      }
    }
    -- use {
    --   "rmagatti/session-lens",
    --   requires = {"rmagatti/auto-session", "nvim-telescope/telescope.nvim"},
    --   config = function()
    --     require("session-lens").setup({})
    --   end
    -- }
    use({ "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.null-ls")
    end,
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
    })
    use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

  end
)

require("plugins.lsp")
