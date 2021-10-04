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

-- dashboard-nvim
--vim.g.dashboard_default_executive = "telescope"



