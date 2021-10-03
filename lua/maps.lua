local map = require('utils').map

-- remap to jkl; from basic vim
map {'', 'l', 'h'}
map {'', ';', 'l'}
map {'', 'h', ';'}

-- map the leader key
map {noremap = false, 'n','<Space>','<Leader>'}

-- map basic vim
map {'n', '<leader>q', ':q<cr>'}
map {'n', '<leader>w', ':w<cr>'}
