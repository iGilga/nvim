require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})

local lsp = require('lspconfig')
local mason_lsp = require('mason-lspconfig')
local mason_nullls = require('mason-null-ls')
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
--  │ Settings null-ls                                         │
--  └──────────────────────────────────────────────────────────┘
mason_nullls.setup({
  ensure_installed = { 'eslint_d', 'stylua', 'prettierd', 'shfmt', 'gitsigns' },
  automatic_installation = false,
  automatic_setup = true, -- Recommended, but optional
})
require('plugins.null-ls')
mason_nullls.setup_handlers()
--  ┌──────────────────────────────────────────────────────────┐
--  │ Settings ui                                              │
--  └──────────────────────────────────────────────────────────┘
require('lsp.handlers')
require('lsp.diagnostics')
