return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = { 'css', 'javascriptreact', 'less', 'sass', 'scss', 'typescriptreact' },
  root_markers = {
    'postcss.config.*s',
    'tailwind.config.*s',
  },
  settings = {
    tailwindCSS = {
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidConfigPath = 'error',
        invalidScreen = 'error',
        invalidTailwindDirective = 'error',
        invalidVariant = 'error',
        recommendedVariantOrder = 'warning',
      },
      validate = true,
    },
  },
}
