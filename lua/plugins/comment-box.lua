local function setup()
  local map = vim.api.nvim_set_keymap
  local opts = function(desc)
    return { noremap = true, silent = true, desc = desc }
  end
  map('n', '<Leader>cl', "<Cmd>lua require('comment-box').lbox(2)<CR>", opts('box'))
  map('v', '<Leader>cl', "<Cmd>lua require('comment-box').lbox(2)<CR>", opts('box'))
  -- centered adapted box with centered text
  map('n', '<Leader>ca', "<Cmd>lua require('comment-box').accbox(2)<CR>", opts('centred box'))
  map('v', '<Leader>ca', "<Cmd>lua require('comment-box').accbox(2)<CR>", opts('centred box'))
  -- full box
  map('n', '<Leader>cc', "<Cmd>lua require('comment-box').cbox(2)<CR>", opts('full box'))
  map('v', '<Leader>cc', "<Cmd>lua require('comment-box').cbox(2)<CR>", opts('full box'))
  -- centered line
  map('n', '<Leader>ci', "<Cmd>lua require('comment-box').cline(1)<CR>", opts('line'))
  -- map('i', '<M-l>', "<Cmd>lua require('comment-box').cline(1)<CR>", opts('line'))
end

return {
  'LudoPinelli/comment-box.nvim',
  config = setup,
}
