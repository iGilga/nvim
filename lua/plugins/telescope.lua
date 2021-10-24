local nnoremap = require("utils.keymap").nnoremap

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}

require("telescope").load_extension("fzf")
--require("telescope").load_extension("session-lens")

-- project.nvim
require("telescope").load_extension("projects")

-- mapping
nnoremap {"<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>"}
nnoremap {"<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>"}
nnoremap {"<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>"}
nnoremap {"<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>"}
nnoremap {"<leader>fs", "<cmd>:lua require('session-lens').search_session()<cr>"}

nnoremap {"<leader>fd", "<cmd>:Telescope projects<cr>"}
