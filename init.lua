if vim.fn.has('nvim-0.8') == 0 then
  error('Need Neovim v0.8+')
end

require('config.settings')
require('config.global')
require('config.lazy')
require('config.mapping')
require('config.commands')
require('config.autocmds')
