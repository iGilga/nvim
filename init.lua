if vim.fn.has('nvim-0.8') == 0 then
  error('Need Neovim v0.8+')
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
require('plugins.lazy')
require('mapping')
require('commands')
require('autocmds')
