local config = require('config')
local map = vim.keymap.set
-- map the leader key
vim.g.mapleader = config.leader

-- remapping from basic vim to jkl;
-- k('', 'l', 'h')
-- k('', ';', 'l')
-- k('', 'h', ';')

-- save and quit
map('n', '<leader>q', ':q<cr>', { desc = 'quit' })
map('n', '<c-q>', ':qa<cr>', { desc = 'quit all' })
map('n', '<leader>s', ':w<cr>', { desc = 'save' })

-- r highlight
map('n', '<F5>', ':nohl<cr>', { desc = 'no highlights' })

-- Packer
map('n', '<leader>pc', '<cmd>PackerCompile<cr>', { desc = 'Packer Compile' })
map('n', '<leader>pi', '<cmd>PackerInstall<cr>', { desc = 'Packer Install' })
map('n', '<leader>ps', '<cmd>PackerSync<cr>', { desc = 'Packer Sync' })
map('n', '<leader>pS', '<cmd>PackerStatus<cr>', { desc = 'Packer Status' })
map('n', '<leader>pu', '<cmd>PackerUpdate<cr>', { desc = 'Packer Update' })

local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

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

-- hop mapping
map('n', 's', function()
  return require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR })
end, { desc = 'Hop char2 after curso' })
map('n', 'S', function()
  return require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR })
end, { desc = 'Hop char2 before cursor' })
map('n', '<leader>l', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", { desc = 'Hop line skip whitespace' })

map('n', 'f', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
    current_line_only = true,
  })
end, { desc = 'hop hint curline' })
map('n', 'F', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
    current_line_only = true,
  })
end, { desc = 'hop hint curline' })
map('n', 't', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
    current_line_only = true,
    hint_offset = -1,
  })
end, { desc = 'hop hint curline before target' })
map('n', 'T', function()
  return require('hop').hint_char1({
    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
    current_line_only = true,
    hint_offset = -1,
  })
end, { desc = 'hop hint curline before target' })
map('n', '<leader>h', function()
  return require('hop').hint_patterns()
end, { desc = 'hop hint with pattern' })

-- nnn.nvim
map('t', '<c-t>', '<cmd>:NnnPicker<cr>', { desc = 'open nnn' })
map('n', '<c-t>', '<cmd>:NnnPicker<cr>', { desc = 'open nnn' })

-- LazyGit
map('n', '<leader>ll', ':LazyGit<cr>', { desc = 'open lazygit' })

-- SessionManager
map('n', '<leader>sl', '<cmd>SessionManager! load_last_session<cr>', { desc = 'Load last session' })
map('n', '<leader>oo', '<cmd>SessionManager! save_current_session<cr>', { desc = 'Save this session' })
map('n', '<leader>od', '<cmd>SessionManager! delete_session<cr>', { desc = 'Delete session' })
map('n', '<leader>sf', '<cmd>SessionManager! load_session<cr>', { desc = 'Search sessions' })
map('n', '<leader>o.', '<cmd>SessionManager! load_current_dir_session<cr>', {
  desc = 'Load current directory session',
})

map('n', '<leader>zf', ':lua require("telescope").extensions.zettel.find_zettel()<CR>')
map('n', '<leader>zg', ':lua require("telescope").extensions.zettel.grep_zettels()<CR>')

map('n', '<Leader>bb', "<Cmd>lua require('comment-box').lbox(2)<CR>", { desc = 'box' })
map('v', '<Leader>bb', "<Cmd>lua require('comment-box').lbox(2)<CR>", { desc = 'box' })

-- centered adapted box with centered text
map('n', '<Leader>bc', "<Cmd>lua require('comment-box').accbox(2)<CR>", { desc = 'centred box' })
map('v', '<Leader>bc', "<Cmd>lua require('comment-box').accbox(2)<CR>", { desc = 'centred box' })

-- centered line
map('n', '<Leader>bl', "<Cmd>lua require('comment-box').cline(1)<CR>", { desc = 'line' })
map('i', '<M-l>', "<Cmd>lua require('comment-box').cline(1)<CR>", { desc = 'line' })
