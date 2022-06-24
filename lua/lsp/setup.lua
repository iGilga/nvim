local lspconfig = require('lspconfig')
local configLsp = require('config').lsp.servers
local defaultProvider = require('lsp.servers.default')

local function setup(servers)
  for _, server in pairs(servers) do
    local serverConfig = {}
    local ok, pserver = pcall(require, 'lsp.servers.' .. server)

    if ok then
      serverConfig = pserver
    end
    local userConfig = configLsp[server].opts or {}
    local opts = valhalla.merge(defaultProvider, serverConfig, userConfig)

    lspconfig[server].setup(opts)
  end
end

setup(vim.tbl_keys(configLsp))
