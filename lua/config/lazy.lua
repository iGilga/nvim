local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', lazypath })
  vim.fn.system({ 'git', '-C', lazypath, 'checkout', 'tags/stable' }) -- last stable release
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  defaults = { lazy = true },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'bugreport',
        'ftplugin',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        -- NOT UNCOMMENT FOLLOWING 2 ROW,
        -- OTHERWISE NOT WORK HIGHLIGHT WITH PAIR {} AND ()!!!!!
        -- 'matchit', NOT UNCOMMENT
        -- 'matchparen', NOT UNCOMMENT, FUCKER.
        'netrw',
        'netrwFileHandlers',
        'netrwPlugin',
        'netrwSettings',
        'optwin',
        'rplugin',
        'rrhelper',
        'spec',
        'spellfile_plugin',
        'synmenu',
        'syntax',
        'tar',
        'tarPlugin',
        'tohtml',
        'tutor',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
      },
    },
  },
  ui = {
    size = { width = 0.8, height = 0.9 },
  },
})
