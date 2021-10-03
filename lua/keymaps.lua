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
