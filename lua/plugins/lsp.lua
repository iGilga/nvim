local lsp = require('lspconfig')
local mason_lsp = require('mason-lspconfig')
local configLsp = require('config').lsp.servers
local defaultConfig = require('lsp.servers.default')

--  ┌──────────────────────────────────────────────────────────┐
--  │ Settings lsp                                             │
--  └──────────────────────────────────────────────────────────┘
mason_lsp.setup({
  ensure_installed = {
    'bashls',
    'cssls',
    'dockerls',
    'graphql',
    'html',
    'jsonls',
    'sumneko_lua',
    'tailwindcss',
    'tsserver',
    'yamlls',
  },
})
mason_lsp.setup_handlers({
  function(serverName)
    local serverConfig, userConfig = {}, {}
    local ok, pserver = pcall(require, 'lsp.servers.' .. serverName)
    if ok then
      serverConfig = pserver
    end
    if configLsp[serverName] then
      userConfig = configLsp[serverName].opts or {}
    end
    local opts = valhalla.merge(defaultConfig, serverConfig, userConfig)
    lsp[serverName].setup(opts)
  end,
})
--  ┌──────────────────────────────────────────────────────────┐
--  │ Settings ui                                              │
--  └──────────────────────────────────────────────────────────┘
require('lsp.handlers')
require('lsp.diagnostics')
