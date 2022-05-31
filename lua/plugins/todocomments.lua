local ok, kanagawa = pcall(require, 'theme.color.kanagawa')

if not ok then
  return false
end

local colors = kanagawa.colors

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
  colors = {
    error = { colors.red },
    warning = { colors.yellow },
    info = { colors.blue },
    hint = { colors.green },
    default = { 'Identifier', '#7C3AED' },
  },
}

-- todo: todo
-- note: note
-- fix: fix
-- warn: warn
-- optim: optim
-- hack: hack

vim.keymap.set('n', '<leader>ft', ':TodoTelescope<cr>')

require('todo-comments').setup(setup)
