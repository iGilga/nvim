local setup = {
  keywords = {
    FIX = {
      icon = ' ',
      color = 'error',
      alt = { 'fix', 'FIXME', 'BUG', 'fixme', 'bug' },
    },
    TODO = { icon = ' ', color = 'info', alt = { 'todo' } },
    HACK = { icon = ' ', color = 'warning', alt = { 'hack' } },
    WARN = { icon = ' ', color = 'warning', alt = { 'warn' } },
    PERF = { icon = ' ', color = 'perf', alt = { 'perf' } },
    NOTE = { icon = ' ', color = 'hint', alt = { 'note', 'INFO', 'info' } },
    TEST = { icon = 'ﭧ ', color = 'test', alt = { 'test' } },
  },
  colors = {
    error = { '#C34043' },
    warning = { '#DCA561' },
    info = { '#7E9CD8' },
    test = { '#957fB8' },
    perf = { '#D27E99' },
    default = { 'Identifier', '#957FB8' },
  },
  search = {
    command = 'rg',
    args = {
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--ignore-case',
    },
    pattern = [[\b(KEYWORDS):]],
  },
}

-- todo: todo
-- note: note
-- fix: fix
-- warn: warn
-- perf: perf
-- hack: hack
-- test: test

vim.keymap.set('n', '<leader>ft', ':TodoTelescope<cr>', { desc = 'telescope with todo' })
vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'next todo comment' })
vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'previous todo comment' })

require('todo-comments').setup(setup)
