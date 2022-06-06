local config = require('config')
local k = vim.keymap
-- map the leader key
vim.g.mapleader = config.leader

-- remapping from basic vim to jkl;
-- k.set('', 'l', 'h')
-- k.set('', ';', 'l')
-- k.set('', 'h', ';')

-- save and quit
k.set('n', '<leader>q', ':q<cr>')
k.set('n', '<c-q>', ':qa<cr>')
k.set('n', '<leader>s', ':w<cr>')

-- reset highlight
k.set('n', '<F5>', ':nohl<cr>')

-- barbar.nvim
local opts = { silent = true }
k.set('n', '<a-k>', ':BufferNext<cr>', opts)
k.set('n', '<a-j>', ':BufferPrevious<cr>', opts)
-- nnoremap({ '<A-0>', ':BufferGotoLast<cr>', opts })
k.set('n', 'ts', ':BufferClose<cr>', opts)
k.set('n', 'tt', ':BufferPick<cr>', opts)
k.set('n', 'tn', ':BufferOrderByBufferNumber<cr>', opts)
k.set('n', 'td', ':BufferOrderByDirectory<cr>', opts)
k.set('n', 'tl', ':BufferOrderByLanguage<cr>', opts)

-- hop mapping
k.set('n', '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>")
k.set('n', '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>")

k.set('n', '<leader>oo', ':SaveSession<cr>')

k.set('t', '<c-t>', '<cmd>:NnnPicker<cr>')
k.set('n', '<c-t>', '<cmd>:NnnPicker<cr>')

-- LazyGit
k.set('n', '<leader>ll', ':LazyGit<cr>')
