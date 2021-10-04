local k = require "utils.keymap"
local noremap = k.noremap
local nnoremap = k.nnoremap
--local vnoremap = k.vnoremap
--local tnoremap = k.tnoremap

-- map the leader key
-- vim.g.mapleader = k.t "<space>"
k.nmap {"<Space>", "<Leader>", {}}
local opts = {}

-- remapping from basic vim to jkl;
noremap {"l", "h", opts}
noremap {";", "l", opts}
noremap {"h", ";", opts}

-- save and quit
nnoremap {"<leader>q", ":q<cr>", opts}
nnoremap {"<c-q>", ":qa<cr>", opts}
nnoremap {"<leader>s", ":w<cr>", opts}

-- barbar.nvim
local opts = {silent = true}
nnoremap {"<A-;>", ":BufferNext<CR>", opts}
nnoremap {"<A-l>", ":BufferPrevious<CR>", opts}

-- hop mapping
nnoremap {"<leader>w", "<cmd>lua require'hop'.hint_words()<cr>"}
nnoremap {"<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>"}

-- telescope
nnoremap {"<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>"}
nnoremap {"<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>"}
nnoremap {"<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>"}
nnoremap {"<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>"}
nnoremap {"<leader>fs", "<cmd>:lua require('session-lens').search_session()<cr>"}

nnoremap {"<leader>fd", "<cmd>:Telescope projects<cr>"}

nnoremap {"<leader>ss", ":SessionSave<cr>"}

nnoremap {"<leader>f", "<cmd>:Format<cr>", {silent = true}}
