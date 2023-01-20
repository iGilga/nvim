return {
  'phaazon/hop.nvim',
  name = 'hop',
  config = function()
    require('hop').setup({
      -- create_hl_autocmd = false,
    })
  end,
}
