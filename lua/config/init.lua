return {
  theme = 'kanagawa',
  border = 'rounded',
  disablePlugins = {'null-ls'},
  lsp = {
    servers = {
      html = true,
      ccsls = true,
      bashls = true,
      jsonls = true,
      sumneko_lua = { format = false },
      denols = { format = true },
      tsserver = { format = false },
      eslint = { format = false },
    },
  },
}
