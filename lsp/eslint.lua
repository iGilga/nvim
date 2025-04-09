-- local root_file = {
--   '.eslintrc',
--   '.eslintrc.js',
--   '.eslintrc.cjs',
--   '.eslintrc.yaml',
--   '.eslintrc.yml',
--   '.eslintrc.json',
--   'eslint.config.js',
--   'eslint.config.mjs',
--   'eslint.config.cjs',
--   'eslint.config.ts',
--   'eslint.config.mts',
--   'eslint.config.cts',
-- }

return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
    'svelte',
    'astro',
  },
  on_attach = function()
    vim.keymap.set('n', '<leader>efa', ':EslintFixAll<cr>', { noremap = true, silent = true, desc = '[eslint]fix all' })
  end,
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
    format = true,
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
