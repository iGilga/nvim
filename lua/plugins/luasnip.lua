local function setup()
  local ls = require('luasnip')

  ls.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
    snip_env = {
      ins_generate = function(nodes)
        return setmetatable(nodes or {}, {
          __index = function(table, key)
            local indx = tonumber(key)
            if indx then
              local val = ls.i(indx)
              rawset(table, key, val)
              return val
            end
          end,
        })
      end,
    },
  })

  ls.filetype_set('javascript', { 'javascriptreact' })
  -- ls.filetype_extend('javascript', { 'javascriptreact' })

  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_lua').lazy_load({ paths = './snippets' })
end

return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  config = setup,
}
