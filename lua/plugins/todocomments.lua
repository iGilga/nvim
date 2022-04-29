local colors = require('theme.color.kanagawa')
local nnoremap = require('utils.keymap').nnoremap

local setup = {}

nnoremap({ '<leader>ft', ':TodoTelescope<cr>' })

require('todo-comments').setup(setup)
