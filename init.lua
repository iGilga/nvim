require("plugins")
require("keymaps")
require "settings"
require("themes/gruvbox")

-- Coq
vim.g.coq_settings = {
  auto_start = true,
  keymap = {
    jump_to_mark = "<leader>c"
  }
  --display = { icons = { mode = 'none' } }
}

local lsp = require "lspconfig"
local nvimlspinstaller = require "nvim-lsp-installer"
local coq = require "coq" -- add this
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp.sumneko_lua.setup {
  cmd = {
    "/home/squirrel/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/Linux/lua-language-server",
    "-E",
    "/home/squirrel/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/main.lua"
  },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      }
    }
  }
}
local servers = {"html", "cssls", "denols", "vuels", "bashls", "yamlls", "jsonls"}
--local servers = nvimlspinstaller.get_installed_servers()
for _, server in pairs(servers) do
  --if not (server == "sumneko_lua") then
  lsp[server].setup {}
  lsp[server].setup(coq.lsp_ensure_capabilities({capabilities = capabilities}))
  --end
end

-- NvimTree
local tree = {}
tree.toggle = function()
  local treeWidth = 30
  vim.g.nvim_tree_width = treeWidth
  require("nvim-tree").toggle()
  if require("nvim-tree.view").win_open() then
    require("bufferline.state").set_offset(treeWidth + 1, "NvimTree")
    require "nvim-tree".find_file(true)
  else
    require("bufferline.state").set_offset(0)
    require "nvim-tree".close()
  end
end

-- Telescope
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}

require("telescope").load_extension("fzf")
require("telescope").load_extension("session-lens")

-- indent-blankline
require("indent_blankline").setup {
  char_list = {"|", "¦", "┆", "┊"},
  show_current_context = true,
  space_char_blankline = " ",
  filetype_exclude = {"help", "dashboard", "NvimTree"}
}

-- project.nvim
-- integration nvim-tree.lua
-- vim.g.nvim_tree_update_cwd = 1
-- vim.g.nvim_tree_respect_buf_cwd = 1

require("telescope").load_extension("projects")

-- dashboard-nvim
vim.g.dashboard_default_executive = "telescope"
--vim.g.dashboard_session_directory = '~/.cache/vim/session'
--map {'n','<leader>sl','<c-u>SessionLoad<cr>'}

-- autosession

-- kcomment
vim.g.kommentary_create_default_mappings = false
require("kommentary.config")
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_default", {})

-- formatter.nvim
require("formatter").setup(
  {
    filetype = {
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

