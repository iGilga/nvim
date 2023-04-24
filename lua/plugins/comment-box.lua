return {
  'LudoPinelli/comment-box.nvim',
  keys = {
    { '<leader>cl', "<cmd>lua require('comment-box').lbox(2)<cr>", mode = { 'n', 'v' }, desc = 'comment box' },
    { '<leader>ca', "<cmd>lua require('comment-box').accbox(2)<cr>", mode = { 'n', 'v' }, desc = 'centred box' },
    { '<leader>cc', "<cmd>lua require('comment-box').cbox(2)<cr>", mode = { 'n', 'v' }, desc = 'full box' },
    { '<leader>ci', "<cmd>lua require('comment-box').cline(1)<cr>", mode = { 'n', 'v' }, desc = 'line' }
  },
}
