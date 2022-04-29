local colors = require('theme.color.kanagawa')
local nnoremap = require('utils.keymap').nnoremap

local setup = {}

nnoremap({ '<leader>ft', ':TODOTelescope<cr>' })

require('todo').setup(setup)
