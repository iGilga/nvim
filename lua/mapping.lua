local config = require('config')
local map = vim.keymap.set
-- map the leader key
vim.g.mapleader = config.leader

-- remapping from basic vim to jkl;
-- k('', 'l', 'h')
-- k('', ';', 'l')
-- k('', 'h', ';')

-- save and quit
map('n', '<leader>q', ':q<cr>', { desc = 'quit' })
map('n', '<c-q>', ':qa<cr>', { desc = 'quit all' })
map('n', '<leader>s', ':w<cr>', { desc = 'save' })

-- r highlight
map('n', '<F5>', ':nohl<cr>', { desc = 'no highlights' })

-- barbar.nvim
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

map('n', '<a-k>', ':BufferNext<cr>', opts('next buffer'))
map('n', '<a-j>', ':BufferPrevious<cr>', opts('prev buffer'))
-- nnoremap({ '<A-0>', ':BufferGotoLast<cr>', opts })
map('n', 'ts', ':BufferClose<cr>', opts('close buffer'))
map('n', 'tt', ':BufferPick<cr>', opts('pick buffer'))
map('n', 'tn', ':BufferOrderByBufferNumber<cr>', opts('sort buffer number'))
map('n', 'td', ':BufferOrderByDirectory<cr>', opts('sort buffer directory'))
map('n', 'tl', ':BufferOrderByLanguage<cr>', opts('sort buffer language'))

-- hop mapping
map('n', '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>", { desc = 'motion word' })
map('n', '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", { desc = 'motion line' })

map('t', '<c-t>', '<cmd>:NnnPicker<cr>', { desc = 'open nnn' })
map('n', '<c-t>', '<cmd>:NnnPicker<cr>', { desc = 'open nnn' })

-- LazyGit
map('n', '<leader>ll', ':LazyGit<cr>', { desc = 'open lazygit' })

map('n', '<leader>sl', '<cmd>SessionManager! load_last_session<cr>', { desc = 'Load last session' })
map('n', '<leader>oo', '<cmd>SessionManager! save_current_session<cr>', { desc = 'Save this session' })
map('n', '<leader>od', '<cmd>SessionManager! delete_session<cr>', { desc = 'Delete session' })
map('n', '<leader>sf', '<cmd>SessionManager! load_session<cr>', { desc = 'Search sessions' })
map('n', '<leader>o.', '<cmd>SessionManager! load_current_dir_session<cr>', {
  desc = 'Load current directory session',
})
