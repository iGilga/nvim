local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- local createCommand = vim.api.nvim_create_user_command
-- local logger = require('utils.logger')
-- Auto sync plugins on save of plugins.lua
-- cmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync" })
--
-- Highlight on yank
local highlight_group = augroup('YankHighlight', { clear = true })
cmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end,
  group = highlight_group,
  pattern = '*',
})

-- Disable diagnostics in node_modules (0 is current buffer only)
-- cmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
-- cmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })

-- Enable spell checking for certain file types
-- cmd({ 'BufRead', 'BufNewFile' }, { pattern = { '*.md', '*.tex' }, command = 'setlocal spell' })

cmd({ 'BufEnter' }, { command = 'lua require("lazygit.utils").project_root_dir()' })

-- cmd({ 'BufEnter' }, { command = 'silent! setlocal foldlevel=99' })

cmd('BufRead', { pattern = '*/openra/*', command = 'setlocal noexpandtab tabstop=4 shiftwidth=4' })

local wrap_md_group = augroup('Markdown Wrap Settings', { clear = true })

cmd('BufEnter', {
  pattern = { '*.md' },
  group = wrap_md_group,
  command = 'setlocal wrap',
})

local customSessionGroup = augroup('CustomSessionGroup', {})

cmd('User', {
  pattern = 'SessionSavePost',
  group = customSessionGroup,
  callback = function()
    require('utils.logger').info('Session saved.')
  end,
})

augroup('alpha_settings', { clear = true })
cmd('User', {
  group = 'alpha_settings',
  pattern = 'AlphaReady',
  callback = function()
    local ls = vim.opt.laststatus
    local st = vim.opt.showtabline
    vim.opt.laststatus = 0
    vim.opt.showtabline = 0
    cmd('BufUnload', {
      pattern = '<buffer>',
      callback = function()
        vim.opt.laststatus = ls
        vim.opt.showtabline = st
      end,
    })
  end,
})
