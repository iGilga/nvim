-- Manage git
return {
  'kdheepak/lazygit.nvim',
  keys = {
    { 'n', '<leader>ll', ':LazyGit<cr>', desc = 'open lazygit' },
  },
  init = function()
    vim.g.lazygit_floating_window_corner_chars = { '┌', '┐', '└', '┘' }
    vim.g.lazygit_floating_window_scaling_factor = 1
  end,
}
