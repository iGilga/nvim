local ls = require('luasnip')

ls.config.set_config({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
})

-- ls.filetype_extend('javascript', { 'html', 'javascriptreact' })
-- ls.add_snippets(nil, {
--   all = {},
--   html = {},
-- })

-- ls.add_snippets('javascript', ls.get_snippets('html'))
-- ls.add_snippets('javascriptreact', ls.get_snippets('html'))
-- ls.add_snippets('typescriptreact', ls.get_snippets('html'))

require('luasnip.loaders.from_vscode').lazy_load()
