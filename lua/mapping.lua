local config = require('config')
local k = require('utils.keymap')
local noremap = k.noremap
local nnoremap = k.nnoremap
local tnoremap = k.tnoremap

-- map the leader key
vim.g.mapleader = config.leader

-- remapping from basic vim to jkl;
noremap({ 'l', 'h' })
noremap({ ';', 'l' })
noremap({ 'h', ';' })

-- save and quit
nnoremap({ '<leader>q', ':q<cr>' })
nnoremap({ '<c-q>', ':qa<cr>' })
nnoremap({ '<leader>s', ':w<cr>' })

-- reset highlight
nnoremap({ '<F5>', ':nohl<cr>' })

-- barbar.nvim
local opts = { silent = true }
nnoremap({ '<a-k>', ':BufferNext<cr>', opts })
nnoremap({ '<a-j>', ':BufferPrevious<cr>', opts })
-- nnoremap({ '<A-0>', ':BufferGotoLast<cr>', opts })
nnoremap({ 'ts', ':BufferClose<cr>', opts })
nnoremap({ 'tt', ':BufferPick<cr>', opts })
nnoremap({ 'tn', ':BufferOrderByBufferNumber<cr>', opts })
nnoremap({ 'td', ':BufferOrderByDirectory<cr>', opts })
nnoremap({ 'tl', ':BufferOrderByLanguage<cr>', opts })

-- hop mapping
nnoremap({ '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>" })
nnoremap({ '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>" })

nnoremap({ '<leader>oo', ':SaveSession<cr>' })

tnoremap({ '<c-t>', '<cmd>:NnnPicker<cr>' })
nnoremap({ '<c-t>', '<cmd>:NnnPicker<cr>' })

-- LazyGit
nnoremap({ '<leader>ll', ':LazyGit<cr>' })
