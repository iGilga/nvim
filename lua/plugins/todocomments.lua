local colors = require('theme.color.kanagawa')
local nnoremap = require('utils.keymap').nnoremap

local setup = {
  keywords = {
    TODO = {
      alt = { 'TODO', 'todo' },
    },
    NOTE = {
      alt = { 'NOTE', 'note' },
    },
    FIX = {
      alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fix', 'fixme', 'fixit' },
    },
    WARN = {
      alt = { 'WARN', 'XXX', 'warn', 'xxx' },
    },
    PERF = {
      alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE', 'optim', 'performance', 'optimize' },
    },
    HACK = {
      alt = { 'HACK', 'hack' },
    },
  },
}

nnoremap({ '<leader>ft', ':TodoTelescope<cr>' })

require('todo-comments').setup(setup)
