local o, wo = vim.o, vim.wo
local opt = vim.opt
local indent = 2

-- Better default
opt.hidden = true -- Don't save when switching buffer
opt.inccommand = "split"
opt.splitright = true
opt.splitbelow = true
opt.mouse = "a"
opt.showmode = false
--opt.fillchars = [[eob: ,vert:│]] -- stl:│,stlnc:│
opt.encoding = "UTF-8"
opt.shortmess:append "cI"
opt.scrolloff = 8
--opt.swapfile = false
--opt.timeout = true
-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Better editor UI
wo.number = true
--wo.relativenumber = true
wo.signcolumn = "yes:1"
wo.cursorline = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
o.backupdir = "~/.nvim/backup/"
o.directory = "~/.nvim/tmp/"
o.undodir = "/tmp/"

-- Colors
opt.termguicolors = true
opt.background = "dark"

-- /
o.smartcase = true
o.ignorecase = true
o.hlsearch = false

-- Tab size options
o.expandtab = true
o.smarttab = true
o.tabstop = indent
o.shiftwidth = indent
o.softtabstop = indent
o.smartindent = true
wo.wrap = false

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- When running macros and regexes on a large file, lazy redraw tells neovim not to draw the screen, which greatly speeds it up, upto 6-7x faster
o.lazyredraw = true
