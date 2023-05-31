return {
  'LudoPinelli/comment-box.nvim',
  keys = {
    { '<leader>cl', "<cmd>lua require('comment-box').llbox(2)<cr>", mode = { 'n', 'v' }, desc = 'Left box of fixed size with Left text' },
    { '<leader>ca', "<cmd>lua require('comment-box').acbox(2)<cr>", mode = { 'n', 'v' }, desc = 'Centered adapted box' },
    { '<leader>cc', "<cmd>lua require('comment-box').ccbox(2)<cr>", mode = { 'n', 'v' }, desc = 'Centered box of fixed size with Centered text' },
    { '<leader>ci', "<cmd>lua require('comment-box').cline(1)<cr>", mode = { 'n', 'v' }, desc = 'Centered line' }
  },
}
