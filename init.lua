require("plugins")
require("keymaps")
require "settings"
require("themes/gruvbox")

local lsp = require "lspconfig"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
 
local servers = {"html", "cssls", "denols", "vuels", "bashls", "yamlls", "jsonls"}
--local servers = nvimlspinstaller.get_installed_servers()
for _, server in pairs(servers) do
  --if not (server == "sumneko_lua") then
  lsp[server].setup {}
  --end
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

-- project.nvim
require("telescope").load_extension("projects")

-- dashboard-nvim
vim.g.dashboard_default_executive = "telescope"



