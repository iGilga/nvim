local map = vim.keymap.set

local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

map('i', 'jk', '<ESC>', { noremap = true, silent = true })
map('i', 'jj', '<ESC>', { noremap = true, silent = true })
map('i', 'kj', '<ESC>', { noremap = true, silent = true })

--                               ┌───────────────┐
--                               │ Save and quit │
--                               └───────────────┘
map('n', '<leader>q', ':q<cr>', { desc = 'quit' })
map('n', '<c-q>', ':qa<cr>', { desc = 'quit all' })
map('n', '<leader>s', ':w<cr>', { desc = 'save' })

--                              ┌─────────────────┐
--                              │ Clear highlight │
--                              └─────────────────┘
map('n', '<F5>', ':nohl<cr>', { desc = 'no highlights' })

--                                    ┌─────┐
--                                    │ Hop │
--                                    └─────┘
map('n', '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>", opts('Hop word'))
map('n', '<leader>l', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", opts('Hop line skip whitespace'))

map('n', 's', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
  })
end, opts('Hop char2 after cursor'))

map('n', 'S', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
  })
end, opts('Hop char2 before cursor'))

map('n', 'f', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
    current_line_only = true,
  })
end, opts('hop hint curline after'))

map('n', 'F', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
    current_line_only = true,
  })
end, opts('hop hint curline before'))

map('n', 't', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
    current_line_only = true,
    hint_offset = -1,
  })
end, opts('hop hint curline before target'))

map('n', 'T', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
    current_line_only = true,
    hint_offset = -1,
  })
end, opts('hop hint curline before target'))

map('n', '<leader>h', function()
  return require('hop').hint_patterns()
end, opts('hop hint with pattern'))

--                                 ┌──────────┐
--                                 │ nnn.nvim │
--                                 └──────────┘
map('t', '<c-t>', '<cmd>:NnnPicker<cr>', opts('open nnn'))
map('n', '<c-t>', '<cmd>:NnnPicker<cr>', opts('open nnn'))

--                                 ┌───────────┐
--                                 │ nvim-tree │
--                                 └───────────┘
map('n', '<leader>mc', '<cmd>:NvimTreeClose<cr>', opts('open nvim-tree'))
map('n', '<leader>m', '<cmd>:NvimTreeFocus<cr>', opts('open nvim-tree'))

--                                  ┌─────────┐
--                                  │ LazyGit │
--                                  └─────────┘
map('n', '<leader>ll', ':LazyGit<cr>', opts('open lazygit'))

--                              ┌────────────────┐
--                              │ SessionManager │
--                              └────────────────┘
-- map('n', '<leader>sl', '<cmd>SessionManager! load_last_session<cr>', opts('Load last session'))
map('n', '<leader>oo', '<cmd>SessionManager! save_current_session<cr>', opts('Save this session'))
map('n', '<leader>od', '<cmd>SessionManager! delete_session<cr>', opts('Delete session'))
map('n', '<leader>sf', '<cmd>SessionManager! load_session<cr>', opts('Search sessions'))
map('n', '<F4>', '<cmd>SessionManager! load_current_dir_session<cr>', {
  desc = 'Load current directory session',
})

--                           ┌───────────────────────┐
--                           │ Telescope with zettel │
--                           └───────────────────────┘
map('n', '<leader>zf', ':lua require("telescope").extensions.zettel.find_zettel()<CR>')
map('n', '<leader>zg', ':lua require("telescope").extensions.zettel.grep_zettels()<CR>')

--                                 ┌───────────┐
--                                 │ Colorizer │
--                                 └───────────┘
map('n', '<a-x>', ':ColorizerToggle<cr>', opts('Toogle colorizer'))
--      ────────────────────────────────────────────────────────────
-- local opt = { noremap = true, silent = false }

-- Create a new note after asking for its title.
-- map("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opt)
--
-- -- Open notes.
-- map("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opt)
--
-- -- Open notes using telescope
-- map('n', '<leader>fn', ':Telescope zk notes<cr>')
--
-- -- Open notes associated with the selected tags.
-- map("n", "<leader>zt", "<Cmd>ZkTags<CR>", opt)
--
-- -- Search for the notes matching a given query.
-- map("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opt)
-- -- Search for the notes matching the current visual selection.
-- map("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opt)

map('n', '<leader>z', "<cmd>lua require('utils.zk').zkcmd()<cr>", opts('Menu zettel'))
