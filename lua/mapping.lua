local config = require('config')
local map = vim.keymap.set

local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

--                                ┌────────────┐
--                                │ Leader key │
--                                └────────────┘
vim.g.mapleader = config.leader

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

--                                  ┌────────┐
--                                  │ Packer │
--                                  └────────┘
map('n', '<leader>pc', '<cmd>PackerCompile<cr>', { desc = 'Packer Compile' })
map('n', '<leader>pi', '<cmd>PackerInstall<cr>', { desc = 'Packer Install' })
map('n', '<leader>ps', '<cmd>PackerSync<cr>', { desc = 'Packer Sync' })
map('n', '<leader>pS', '<cmd>PackerStatus<cr>', { desc = 'Packer Status' })
map('n', '<leader>pu', '<cmd>PackerUpdate<cr>', { desc = 'Packer Update' })

--                                 ┌──────────┐
--                                 │ WhichKey │
--                                 └──────────┘
map('n', '<F9>', '<cmd>WhichKey<cr>', { noremap = true, silent = true })

--                                ┌────────────┐
--                                │ Bufferline │
--                                └────────────┘
map('n', '<a-k>', ':BufferLineCycleNext<cr>', opts('next buffer'))
map('n', '<a-j>', ':BufferLineCyclePrev<cr>', opts('prev buffer'))
-- nnoremap({ '<A-0>', ':BufferGotoLast<cr>', opts })
map('n', 'ts', ':BufferLinePickClose<cr>', opts('close buffer'))
map('n', 'tss', ':bdelete<cr>', opts('close buffer'))
map('n', 'tt', ':BufferLinePick<cr>', opts('pick buffer'))
map('n', 'tn', function()
  require('bufferline').sort_buffers_by(function(buf_a, buf_b)
    return buf_a.id < buf_b.id
  end)
end, opts('sort buffer number'))
map('n', 'td', function()
  require('bufferline').sort_buffers_by('directory')
end, opts('sort buffer directory'))
map('n', 'te', function()
  require('bufferline').sort_buffers_by('extension')
end, opts('sort buffer language'))

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

--                                ┌─────────────┐
--                                │ Comment box │
--                                └─────────────┘
map('n', '<Leader>bb', "<Cmd>lua require('comment-box').lbox(2)<CR>", opts('box'))
map('v', '<Leader>bb', "<Cmd>lua require('comment-box').lbox(2)<CR>", opts('box'))
-- centered adapted box with centered text
map('n', '<Leader>bc', "<Cmd>lua require('comment-box').accbox(2)<CR>", opts('centred box'))
map('v', '<Leader>bc', "<Cmd>lua require('comment-box').accbox(2)<CR>", opts('centred box'))
-- centered line
map('n', '<Leader>bl', "<Cmd>lua require('comment-box').cline(1)<CR>", opts('line'))
-- map('i', '<M-l>', "<Cmd>lua require('comment-box').cline(1)<CR>", opts('line'))

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
