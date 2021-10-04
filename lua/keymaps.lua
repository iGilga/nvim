local k = require "utils.keymap"
local noremap = k.noremap
local nnoremap = k.nnoremap
--local vnoremap = k.vnoremap
--local tnoremap = k.tnoremap

-- map the leader key
-- vim.g.mapleader = k.t "<space>"
k.nmap {"<Space>", "<Leader>"}

-- remapping from basic vim to jkl;
noremap {"l", "h"}
noremap {";", "l"}
noremap {"h", ";"}

-- save and quit
nnoremap {"<leader>q", ":q<cr>"}
nnoremap {"<c-q>", ":qa<cr>"}
nnoremap {"<leader>s", ":w<cr>"}

-- barbar.nvim
local opts = {silent = true}
nnoremap {"<A-;>", ":BufferNext<CR>", opts}
nnoremap {"<A-l>", ":BufferPrevious<CR>", opts}

-- hop mapping
nnoremap {"<leader>w", "<cmd>lua require'hop'.hint_words()<cr>"}
nnoremap {"<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>"}

nnoremap {"<leader>ss", ":SessionSave<cr>"}

nnoremap {"<leader>f", "<cmd>:Format<cr>", opts}
