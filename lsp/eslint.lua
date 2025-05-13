return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'astro',
    'javascript',
    'javascript.jsx',
    'javascriptreact',
    'svelte',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
    'vue',
  },
  root_markers = { '.eslintrc', '.eslintrc.*', 'eslint.config.*s' },
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = 'separateLine',
      },
      showDocumentation = {
        enable = true,
      },
    },
    codeActionOnSave = {
      enable = false,
      mode = 'all',
    },
    experimental = {
      useFlatConfig = false,
    },
    nodePath = '',
    onIgnoredFiles = 'off',
    problems = {
      shortenToSingleLine = false,
    },
    quiet = false,
    rulesCustomizations = {},
    run = 'onType',
    useESLintClass = false,
    validate = 'on',
    workingDirectory = {
      mode = 'location',
    },
  },
}
