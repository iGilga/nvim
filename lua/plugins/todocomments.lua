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
    error = { '#C34043' },
    warning = { '#DCA561' },
    info = { '#7E9CD8' },
    hint = { '#76946A' },
    default = { 'Identifier', '#957FB8' },
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
