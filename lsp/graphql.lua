return {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql', 'javascriptreact', 'typescriptreact' },
  root_markers = { '.git', '.graphql.config.*', '.graphqlrc*', 'graphql.config.*' },
}
