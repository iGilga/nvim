pcall(require, 'impatient')
-- pcall(function()
--   require('impatient').enable_profile()
-- end)

local o, c, g = vim.opt, vim.cmd, vim.g

local ok_filetype, filetype = pcall(require, 'filetype')

if ok_filetype then
  filetype.setup({})
  -- deactivate vim based filetype detection
  g.did_load_filetype = 1
end

require('settings')

c('filetype plugin indent on')

require('global')
require('plugins')
require('mapping')
require('autocmds')
require('highlight')
