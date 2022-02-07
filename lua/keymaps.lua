local k = require('utils.keymap')
local noremap = k.noremap
local nnoremap = k.nnoremap
local tnoremap = k.tnoremap

-- map the leader key
vim.g.mapleader = k.t('<Space>')
--k.nmap {"<Space>", "<Leader>"}

-- remapping from basic vim to jkl;
noremap({ 'l', 'h' })
noremap({ ';', 'l' })
noremap({ 'h', ';' })

-- save and quit
nnoremap({ '<leader>q', ':q<cr>' })
nnoremap({ '<c-q>', ':qa<cr>' })
nnoremap({ '<leader>s', ':w<cr>' })

-- barbar.nvim
local opts = { silent = true }
nnoremap({ '<A-;>', ':BufferNext<cr>', opts })
nnoremap({ '<A-l>', ':BufferPrevious<cr>', opts })
nnoremap({ '<A-1>', ':BufferGoto 1<cr>', opts })
nnoremap({ '<A-2>', ':BufferGoto 2<cr>', opts })
nnoremap({ '<A-3>', ':BufferGoto 3<cr>', opts })
nnoremap({ '<A-4>', ':BufferGoto 4<cr>', opts })
nnoremap({ '<A-5>', ':BufferGoto 5<cr>', opts })
nnoremap({ '<A-6>', ':BufferGoto 6<cr>', opts })
nnoremap({ '<A-7>', ':BufferGoto 7<cr>', opts })
nnoremap({ '<A-8>', ':BufferGoto 8<cr>', opts })
nnoremap({ '<A-9>', ':BufferGoto 9<cr>', opts })
nnoremap({ '<A-0>', ':BufferGotoLast<cr>', opts })
nnoremap({ 'ts', ':BufferClose<cr>', opts })
nnoremap({ 'tt', ':BufferPick<cr>', opts })
nnoremap({ 'tn', ':BufferOrderByBufferNumber<cr>', opts })
nnoremap({ 'td', ':BufferOrderByDirectory<cr>', opts })
nnoremap({ 'tl', ':BufferOrderByLanguage<cr>', opts })

-- hop mapping
nnoremap({ '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>" })
nnoremap({ '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>" })

nnoremap({ '<leader>ss', ':SaveSession<cr>' })
nnoremap({ '<leader>sl', ':silent Telescope session-lens search_session' })

tnoremap({ '<c-t>', '<cmd>:NnnPicker<cr>' })
nnoremap({ '<c-t>', '<cmd>:NnnPicker<cr>' })
