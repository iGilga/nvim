-- Manage git
return {
  'kdheepak/lazygit.nvim',
  init = function()
    vim.g.lazygit_floating_window_corner_chars = { '┌', '┐', '└', '┘' }
    vim.g.lazygit_floating_window_scaling_factor = 1
  end,
}
