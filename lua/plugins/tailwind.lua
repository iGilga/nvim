return {
  {
    'laytan/tailwind-sorter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    build = 'cd formatter && npm i && npm run build',
  },
  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    -- optionally, override the default options:
    config = function()
      require('tailwindcss-colorizer-cmp').setup({
        color_square_width = 2,
      })
    end,
  },
}
