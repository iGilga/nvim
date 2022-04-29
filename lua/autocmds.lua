-- Auto sync plugins on save of plugins.lua
-- vim.api.nvim_create_autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync" })
--
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end,
  group = highlight_group,
  pattern = '*',
})

-- Disable diagnostics in node_modules (0 is current buffer only)
-- vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
-- vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = { '*.md', '*.tex' }, command = 'setlocal spell' })

vim.api.nvim_create_autocmd({ 'BufEnter' }, { command = ':lua require("lazygit.utils").project_root_dir()' })