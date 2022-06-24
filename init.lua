if vim.fn.has('nvim-0.7') == 0 then
  error('Need Neovim v0.7+')
end

do
  local ok, _ = pcall(require, 'impatient')

  if not ok then
    vim.notify('impatient.nvim not installed', vim.log.levels.WARN)
  end
end

-- pcall(function()
--   require('impatient').enable_profile()
-- end)

local ok_filetype, filetype = pcall(require, 'filetype')

if ok_filetype then
  filetype.setup({})
  -- deactivate vim based filetype detection
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetype = 0
end

require('settings')

vim.api.nvim_command('filetype plugin indent on')
-- vim.cmd('filetype plugin indent on')

require('global')
require('plugins')
require('mapping')
require('autocmds')
