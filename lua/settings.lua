local g, o, opt = vim.g, vim.o, vim.opt
local indent = 2

-- Better default
-- opt.inccommand = "split"
opt.splitright = true
opt.splitbelow = true
opt.mouse = 'a'
-- opt.showmode = false
opt.fillchars = { eob = ' ' }
opt.encoding = 'UTF-8'
opt.shortmess:append('sI')
opt.scrolloff = 8
--opt.swapfile = false
--opt.timeout = true
-- Decrease update time
opt.timeoutlen = 400
opt.updatetime = 250

-- Better editor UI
opt.number = true
opt.numberwidth = 2
--opt.relativenumber = true
opt.signcolumn = 'yes:1'
opt.cursorline = true

-- Undo and backup options
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.swapfile = false
opt.backupdir = '~/.nvim/backup/'
opt.directory = '~/.nvim/tmp/'
opt.undodir = '/tmp/'

-- Colors
opt.termguicolors = true
opt.background = 'dark'

opt.hidden = true -- Don't save when switching buffer
opt.smartcase = true
opt.ignorecase = true
-- o.hlsearch = false

-- Tab size options
opt.expandtab = true
opt.smarttab = true
opt.tabstop = 8
opt.shiftwidth = indent
-- o.softtabstop = indent
opt.smartindent = true
opt.wrap = false

-- Makes neovim and host OS clipboard play nicely with each other
opt.clipboard = 'unnamedplus'
opt.cmdheight = 1
-- When running macros and regexes on a large file, lazy redraw tells neovim not to draw the screen, which greatly speeds it up, upto 6-7x faster
opt.lazyredraw = true

-- Set completeopt to have a better completion experience
opt.completeopt = 'menu,menuone,noselect'

o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

-- disable some builtin vim plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'matchparen',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
  'spec',
}

for _, plugin in pairs(disabled_built_ins) do
  g['loaded_' .. plugin] = 1
end
