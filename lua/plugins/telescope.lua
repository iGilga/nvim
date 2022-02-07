local nnoremap = require('utils.keymap').nnoremap

local telescope = require('telescope')
local actions = require('telescope.actions')

local trouble = require('trouble.providers.telescope')

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      '.git/',
    },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<c-h>'] = 'which_key',
        ['<c-n>'] = trouble.open_with_trouble,
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
        ['<c-n>'] = trouble.open_with_trouble,
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
    project = {
      base_dir = {
        '~/project',
      },
    },
  },
})

telescope.load_extension('fzf')
telescope.load_extension('session-lens')
telescope.load_extension('hop')
-- require('telescope').load_extension('projects')

-- mapping
nnoremap({ '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>" })
nnoremap({ '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>" })
nnoremap({ '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>" })
nnoremap({ '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>" })
nnoremap({ '<leader>fq', "<cmd>lua require('telescope.builtin').quickfix()<cr>" })

nnoremap({ '<leader>gb', '<cmd>lua require("telescope.builtin").git_bcommits()<cr>' })
nnoremap({ '<leader>gs', '<cmd>lua require("telescope.builtin").git_status()<cr>' })

nnoremap({ '<leader>sl', "<cmd>:lua require('session-lens').search_session()<cr>" })
-- nnoremap({ '<leader>fd', '<cmd>:Telescope projects<cr>' })
