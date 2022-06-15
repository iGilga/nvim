local map = vim.keymap.set
local u = require('utils')
local telescope = require('telescope')
local actions = require('telescope.actions')

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

local wideVertical = {
  sorting_strategy = 'ascending',
  layout_strategy = 'vertical',
  layout_config = {
    anchor = 'N',
    width = { padding = 6 },
    height = { padding = 1 },
    preview_height = 0.65,
  },
}

local wideHorizontal = {
  sorting_strategy = 'ascending',
  layout_strategy = 'horizontal',
  layout_config = {
    anchor = 'N',
    width = { padding = 6 },
    height = { padding = 1 },
    preview_width = 0.65,
  },
}

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--no-ignore',
      '--smart-case',
      '--hidden',
    },
    prompt_prefix = ' >  ',
    results_title = false,
    selection_caret = '  ',
    entry_prefix = '  ',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    -- layout_strategy = vim.o.lines > 55 and 'vertical' or 'horizontal',
    set_env = { ['COLORTERM'] = 'truecolor' },
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        width = { padding = 2 },
        height = { padding = 2 },
        preview_width = 0.60,
      },
      vertical = {
        prompt_position = 'top',
        width = { padding = 2 },
        height = { padding = 2 },
        preview_width = 0.60,
      },
    },
    borderchars = { ' ' },
    -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    -- color_devicons = true,
    path_display = { 'smart' },
    use_less = true,
    winblend = 0,
    border = {},
    file_ignore_patterns = {
      'node_modules/',
      'vendor/',
      '.git/',
    },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<c-h>'] = 'which_key',
        ['<c-l>'] = R('telescope').extensions.hop.hop, -- hop.hop_toggle_selection
        ['<c-o>'] = function(prompt_bufnr)
          local opts = {
            callback = actions.toggle_selection,
            loop_callback = actions.send_selected_to_qflist,
          }
          telescope.extensions.hop._hop_loop(prompt_bufnr, opts)
        end,
      },
      n = {
        ['<c-h>'] = 'which_key',
        ['<c-l>'] = R('telescope').extensions.hop.hop, -- hop.hop_toggle_selection
        ['<c-o>'] = function(prompt_bufnr)
          local opts = {
            callback = actions.toggle_selection,
            loop_callback = actions.send_selected_to_qflist,
          }
          telescope.extensions.hop._hop_loop(prompt_bufnr, opts)
        end,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    hop = {
      -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
      keys = {
        'a',
        's',
        'd',
        'f',
        'g',
        'h',
        'j',
        'k',
        'l',
        ';',
        'q',
        'w',
        'e',
        'r',
        't',
        'y',
        'u',
        'i',
        'o',
        'p',
        'A',
        'S',
        'D',
        'F',
        'G',
        'H',
        'J',
        'K',
        'L',
        ':',
        'Q',
        'W',
        'E',
        'R',
        'T',
        'Y',
        'U',
        'I',
        'O',
        'P',
      },
      -- Highlight groups to link to signs and lines; the below configuration refers to demo
      -- sign_hl typically only defines foreground to possibly be combined with line_hl
      sign_hl = { 'WarningMsg', 'Title' },
      -- optional, typically a table of two highlight groups that are alternated between
      line_hl = { 'CursorLine', 'Normal' },
      -- options specific to `hop_loop`
      -- true temporarily disables Telescope selection highlighting
      clear_selection_hl = false,
      -- highlight hopped to entry with telescope selection highlight
      -- note: mutually exclusive with `clear_selection_hl`
      trace_entry = true,
      -- jump to entry where hoop loop was started from
      reset_selection = true,
    },
  },
  pickers = {
    -- find_files = u.merge(wideHorizontal, {}),
    --   live_grep = u.merge(wideHorizontal, {}),
    --   grep_string = u.merge(wideHorizontal, {}),
    --   diagnostics = u.merge(wideHorizontal, {}),
    --   lsp_references = u.merge(wideHorizontal, {}),
    --   help_tags = u.merge(wideHorizontal, {}),
    --   buffers = u.merge(wideHorizontal, {}),
  },
})

telescope.load_extension('zf-native')
telescope.load_extension('session-lens')
telescope.load_extension('hop')
telescope.load_extension('notify')
require('telescope').load_extension('lazygit')
require('telescope').load_extension('projects')

-- mapping
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = 'search files' })
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", { desc = 'search word' })
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", { desc = 'search buffers' })
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", { desc = 'search help' })
-- map('n', '<leader>fq', "<cmd>lua require('telescope.builtin').quickfix()<cr>", { desc = 'search quickfix' })
map('n', '<leader>fo', "<cmd>lua require('telescope.builtin').oldfiles()<cr>", { desc = 'search oldfiles' })
map('n', '<leader>fm', "<cmd>lua require('telescope.builtin').marks()<cr>", { desc = 'search marks' })
map('n', '<leader>fll', "<cmd>lua require('telescope').extensions.lazygit.lazygit()<cr>", { desc = 'search git repo' })
map(
  'n',
  '<leader>tn',
  "<cmd>lua require('telescope').extensions.notify.notify({layout_strategy='vertical'})<cr>",
  { desc = 'search notify' }
)
-- map('n', '<leader>gf', '<cmd>lua require("telescope.builtin").git_files()<cr>', { desc = 'search files' })
-- map('n', '<leader>gb', '<cmd>lua require("telescope.builtin").git_bcommits()<cr>', { desc = 'search files' })
-- map('n', '<leader>gs', '<cmd>lua require("telescope.builtin").git_status()<cr>', { desc = 'search files' })

map('n', '<leader>sl', ':Telescope session-lens search_session<cr>', { desc = 'search sessions' })
map('n', '<leader>fd', '<cmd>:Telescope projects<cr>', { desc = 'search projects' })
