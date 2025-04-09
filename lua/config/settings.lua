local g, o, opt = vim.g, vim.o, vim.opt
local indent = 2

local options = {
  backup = false,
  backupdir = '~/.nvim/backup/',
  clipboard = 'unnamedplus',
  cmdheight = 0,
  completeopt = 'menuone,noselect',
  cursorline = true,
  directory = '~/.nvim/tmp/',
  encoding = 'UTF-8',
  expandtab = true,
  fillchars = { eob = ' ' },
  hidden = true, -- Don't save when switching buffer
  -- hlsearch = false,
  ignorecase = true,
  -- inccommand = "split",
  lazyredraw = true,
  -- mouse = 'a',
  -- Number
  number = true,
  numberwidth = 2,
  relativenumber = true,
  ruler = false,
  scrolloff = 4,
  shiftwidth = indent,
  shortmess = opt.shortmess + 'sI',
  -- showmode = false,
  signcolumn = 'yes',
  smartcase = true,
  smartindent = true,
  smarttab = true,
  -- softtabstop = indent,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 8,
  -- timeout = true,
  timeoutlen = 400,
  -- undodir = '/tmp/',
  undofile = true,
  updatetime = 250,
  wrap = false,
  writebackup = false,
  listchars = {
    space = '·',
    tab = '-->',
  },
  langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz',
  conceallevel = 2,
}

for option, value in pairs(options) do
  opt[option] = value
end

o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

--                                ┌────────────┐
--                                │ Leader key │
--                                └────────────┘
g.mapleader = ' '

-- enable autostart for co-- dashboard-nvim
-- g.dashboard_default_executive = 'telescope'
-- g.indent_blankline_show_trailing_blankline_indent = false
g.bufferline = {
  add_in_buffer_number_order = true,
}
