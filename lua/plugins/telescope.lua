local nnoremap = require('utils.keymap').nnoremap

require('telescope').setup({
  defaults = {
    prompt_prefix = ' ',
    file_ignore_patterns = {
      '.git/',
    },
    dynamic_preview_title = true,
    vimgrep_arguments = {
      'rg',
      '--ignore',
      '--hiden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
    },
    mappings = {
      i = {
        ['<esc>'] = require('telescope.actions').close,
        ['<C-h>'] = 'which_key',
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
    project = {
      base_dir = {
        '~/project',
      },
    },
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('session-lens')
require('telescope').load_extension('projects')

-- mapping
nnoremap({ '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>" })
nnoremap({ '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>" })
nnoremap({ '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>" })
nnoremap({ '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>" })
nnoremap({ '<leader>sl', "<cmd>:lua require('session-lens').search_session()<cr>" })

nnoremap({ '<leader>h', '<cmd>lua require("telescope.builtin").git_bcommits()<cr>' })
nnoremap({ '<leader>i', '<cmd>lua require("telescope.builtin").git_status()<cr>' })

nnoremap({ '<leader>fd', '<cmd>:Telescope projects<cr>' })
