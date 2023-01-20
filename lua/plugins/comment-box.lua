local function setup()
  local keymap = vim.api.nvim_set_keymap

  keymap('n', '<Leader>cl', "<Cmd>lua require('comment-box').lbox()<CR>", {})
  keymap('v', '<Leader>cl', "<Cmd>lua require('comment-box').lbox()<CR>", {})

  keymap('n', '<Leader>cc', "<Cmd>lua require('comment-box').cbox()<CR>", {})
  keymap('v', '<Leader>cc', "<Cmd>lua require('comment-box').cbox()<CR>", {})

  keymap('n', '<Leader>ci', "<Cmd>lua require('comment-box').line()<CR>", {})
  keymap('i', '<-l>', "<Cmd>lua require('comment-box').line()<CR>", {})
end

return {
  'LudoPinelli/comment-box.nvim',
  config = setup,
}
