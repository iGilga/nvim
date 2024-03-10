local function setup()
  local lsp = require('lspconfig')
  local mason_lsp = require('mason-lspconfig')
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
      'rust_analyzer',
      'tailwindcss',
      'tsserver',
      'yamlls',
    },
  })

  local blocklist = {
    ['rust_analyzer'] = true,
    ['emmet_language_server'] = true,
    ['graphql'] = true,
    ['tailwindcss'] = true,
  }

  mason_lsp.setup_handlers({
    function(serverName)
      if blocklist[serverName] then
        return
      end
      local opts = defaultConfig
      local ok, serverConfig = pcall(require, 'lsp.servers.' .. serverName)
      if ok then
        opts = valhalla.merge(opts, serverConfig)
      end
      lsp[serverName].setup(opts)
    end,
  })

  --  ┌──────────────────────────────────────────────────────────┐
  --  │ Settings ui                                              │
  --  └──────────────────────────────────────────────────────────┘
  require('lsp.diagnostics')
end

return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'b0o/SchemaStore.nvim' },
    { 'folke/neodev.nvim',   opts = {} },
    'mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = setup,
}
