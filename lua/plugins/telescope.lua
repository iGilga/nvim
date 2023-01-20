local function setup()
  local map = vim.keymap.set
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local action_layout = require('telescope.actions.layout')

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
          width = { padding = 0 },
          height = { padding = 0 },
          preview_width = 0.65,
        },
        vertical = {
          prompt_position = 'top',
          width = { padding = 0 },
          height = { padding = 0 },
          preview_width = 0.65,
        },
      },
      borderchars = { ' ' },
      -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      path_display = { shorten = 1 },
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
          ['jj'] = { '<esc>', type = 'command' },
          ['<esc>'] = actions.close,
          ['<c-h>'] = 'which_key',
          ['<c-p>'] = action_layout.toggle_preview,
        },
        n = {
          ['<c-h>'] = 'which_key',
          ['<c-p>'] = action_layout.toggle_preview,
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
      ['ui-select'] = {
        require('telescope.themes').get_dropdown({
          initial_mode = 'normal',
          borderchars = { ' ' },
        }),
      },
    },
    pickers = {
      diagnostics = {
        initial_mode = 'normal',
      },
      lsp_references = {
        initial_mode = 'normal',
        show_line = false,
      },
      marks = {
        initial_mode = 'normal',
        layout_config = {
          horizontal = {
            -- width = { padding = 10 },
            -- height = { padding = 5 },
            width = 0.8,
            height = 0.9,
            preview_width = 0.40,
          },
        },
      },
    },
  })

  telescope.load_extension('fzf')
  telescope.load_extension('ui-select')
  telescope.load_extension('notify')

  local ok, _ = pcall(require, 'harpoon')
  if ok then
    telescope.load_extension('harpoon')
  end

  -- telescope.load_extension('lazygit')
  -- telescope.load_extension('projects')

  -- mapping
  map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = 'search files' })
  map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", { desc = 'search word' })
  map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", { desc = 'search buffers' })
  map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", { desc = 'search help' })
  map('n', '<leader>fq', "<cmd>lua require('telescope.builtin').quickfix()<cr>", { desc = 'search quickfix' })
  map('n', '<leader>fl', "<cmd>lua require('telescope.builtin').loclist()<cr>", { desc = 'search loclist' })
  map('n', '<leader>fp', "<cmd>lua require('telescope.builtin').commands()<cr>", { desc = 'search commands' })
  map('n', '<leader>fo', "<cmd>lua require('telescope.builtin').oldfiles()<cr>", { desc = 'search oldfiles' })
  map('n', '<leader>fm', "<cmd>lua require('telescope.builtin').marks()<cr>", { desc = 'search marks' })
  map('n', '<leader>fe', "<cmd>lua require('telescope.builtin').registers()<cr>", { desc = 'search resigters' })
  map('n', '<leader>fr', "<cmd>lua require('telescope.builtin').resume()<cr>", { desc = 'last telescope' })
  map('n', '<leader>fk', "<cmd>lua require('telescope.builtin').keymaps()<cr>", { desc = 'search keymaps' })
  map(
    'n',
    '<leader>fll',
    "<cmd>lua require('telescope').extensions.lazygit.lazygit()<cr>",
    { desc = 'search git repo' }
  )
  map(
    'n',
    '<leader>tn',
    "<cmd>lua require('telescope').extensions.notify.notify({layout_strategy='vertical'})<cr>",
    { desc = 'search notify' }
  )
  map('n', '<leader>gf', '<cmd>lua require("telescope.builtin").git_files()<cr>', { desc = 'search git files' })
  map('n', '<leader>gb', '<cmd>lua require("telescope.builtin").git_bcommits()<cr>', { desc = 'search files' })
  map('n', '<leader>gs', '<cmd>lua require("telescope.builtin").git_status()<cr>', { desc = 'search files' })

  -- map('n', '<leader>fd', '<cmd>:Telescope projects<cr>', { desc = 'search projects' })
end

return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'kdheepak/lazygit.nvim' },
    { 'nvim-telescope/telescope-symbols.nvim' },
    { 'rcarriga/nvim-notify' },
  },
  cmd = 'Telescope',
  config = setup,
}
