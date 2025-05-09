-- Manage git
return {
  'kdheepak/lazygit.nvim',
  keys = {
    { '<leader>ll', ':LazyGit<cr>', desc = 'open lazygit' },
  },
  init = function()
    vim.g.lazygit_floating_window_border_chars = { '┌', '┐', '└', '┘' }
    vim.g.lazygit_floating_window_scaling_factor = 1
  end,
}
