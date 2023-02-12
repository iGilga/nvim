local function setup()
  local lsp = require('lspconfig')
  local mason_lsp = require('mason-lspconfig')
  local configLsp = require('config.user').lsp.servers
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
      'lua_ls',
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
end

return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'b0o/SchemaStore.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = setup,
}
