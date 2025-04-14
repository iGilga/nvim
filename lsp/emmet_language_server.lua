return {
  cmd = { 'emmet-language-server', '--stdio' },
  root_markers = { '.git' },
  filetypes = {
    'astro',
    'css',
    'eruby',
    'html',
    'javascript',
    'javascriptreact',
    'less',
    'pug',
    'sass',
    'scss',
    'svelte',
    'svelte',
    'typescriptreact',
    'vue',
  },
  -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
  -- **Note:** only the options listed in the table are supported.
  init_options = {
    excludeLanguages = {},
    preferences = {},
    showAbbreviationSuggestions = true,
    showExpandedAbbreviation = 'always',
    showSuggestionsAsSnippets = false,
    syntaxProfiles = {},
    variables = {},
  },
}
