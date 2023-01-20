return {
  'danymat/neogen',
  keys = {
    {
      '<leader>nf',
      function()
        require('neogen').generate({})
      end,
      {
        noremap = true,
        silent = true,
        desc = '[neogen] generate annotation',
      },
    },
  },
  opts = {
    snippet_engine = 'luasnip',
  },
  enabled = false,
}
