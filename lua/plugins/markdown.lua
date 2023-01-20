return {
  { 'ellisonleao/glow.nvim', branch = 'main', cmd = 'Glow' },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    enabled = false,
  },
}
