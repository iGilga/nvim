return {
  on_attach = function()
    vim.keymap.set('n', '<leader>efa', ':EslintFixAll<cr>', { noremap = true, silent = true, desc = '[eslint]fix all' })
  end
}
