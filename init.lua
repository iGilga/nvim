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

require('settings')
require('global')
require('plugins')
require('mapping')
require('autocmds')
