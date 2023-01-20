local function setup()
  local ls = require('luasnip')

  ls.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
  })

  ls.filetype_set('javascript', { 'javascriptreact' })
  -- ls.filetype_extend('javascript', { 'javascriptreact' })

  require('luasnip.loaders.from_vscode').lazy_load()
end

return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  config = setup,
}
