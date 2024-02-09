return {
  "chrisgrieser/nvim-scissors",
  dependencies = "nvim-telescope/telescope.nvim", -- optional
  opts = {
    snippetDir = vim.fn.stdpath("config") .. "/snippers",
  },
  keys = function()
    local sc = require('scissors');
    return {
      { '<leader>se', sc.editSnippet },
      { '<leader>sa', sc.addNewSnippet,  mode = { 'n', 'x' }, }
    }
  end
}
