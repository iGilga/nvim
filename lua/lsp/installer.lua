local lspinstaller = require('nvim-lsp-installer')
local u = require('utils')
local configLsp = require('config').lsp.servers
local defaultProvider = require('lsp.servers.default')

lspinstaller.settings({
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
})

local lspinstallerservers = require('nvim-lsp-installer.servers')

for _, requestedServer in pairs(configLsp) do
  local ok, server = lspinstallerservers.get_server(requestedServer)
  if ok then
    if not server:is_installed() then
      server:install()
    end
  end
end

lspinstaller.on_server_ready(function(server)
  local serverConfig = {}
  local ok, pserver = pcall(require, 'lsp.servers.' .. server.name)

  if ok then
    serverConfig = pserver
  end
  local userConfig = configLsp[server.name].opts or {}
  local opts = u.merge(defaultProvider, serverConfig, userConfig)

  server:setup(opts)
end)
