local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

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

cmd({ 'BufEnter' }, { command = 'lua require("lazygit.utils").project_root_dir()' })

-- cmd('BufRead', { pattern = '*/openra/*', command = 'setlocal noexpandtab tabstop=4 shiftwidth=4' })

local customSessionGroup = augroup('CustomSessionGroup', {})

cmd('User', {
  pattern = 'SessionSavePost',
  group = customSessionGroup,
  callback = function()
    require('utils.logger').Logger.info('Session saved.')
  end,
})

local alpha_settings = augroup('alpha_settings', { clear = true })

cmd('User', {
  group = alpha_settings,
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

-- cmd('LspAttach', {
--   callback = function(ev)
--     vim.print('LspAttach')
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
