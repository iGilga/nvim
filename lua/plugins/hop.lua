local keys = {
  { '<leader>w', "<cmd>lua require'hop'.hint_words()<cr>", desc = 'Hop word' },
  -- { '<leader>l', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", desc = 'Hop line skip whitespace', { noremap = true } },
  {
    's',
    function()
      return require('hop').hint_char1({
        direction = require('hop.hint').HintDirection.AFTER_CURSOR,
      })
    end,
    desc = 'Hop char2 after cursor',
  },
  {
    'S',
    function()
      return require('hop').hint_char1({
        direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
      })
    end,
    desc = 'Hop char2 before cursor',
  },
  {
    'f',
    function()
      return require('hop').hint_char1({
        direction = require('hop.hint').HintDirection.AFTER_CURSOR,
        current_line_only = true,
      })
    end,
    desc = 'hop hint curline after',
  },
  {
    'F',
    function()
      return require('hop').hint_char1({
        direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
        current_line_only = true,
      })
    end,
    desc = 'hop hint curline before',
  },
  {
    't',
    function()
      return require('hop').hint_char1({
        direction = require('hop.hint').HintDirection.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1,
      })
    end,
    desc = 'hop hint curline before target',
  },
  {
    'T',
    function()
      return require('hop').hint_char1({
        direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = -1,
      })
    end,
    desc = 'hop hint curline before target',
  },
}
return {
  'phaazon/hop.nvim',
  name = 'hop',
  keys = keys,
  config = function()
    require('hop').setup({
      -- create_hl_autocmd = false,
    })
  end,
}
