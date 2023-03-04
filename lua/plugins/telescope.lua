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
          ['<esc>'] = actions.close,
          ['<c-h>'] = 'which_key',
          ['<c-p>'] = action_layout.toggle_preview,
          ['<C-f>'] = actions.smart_send_to_qflist + actions.open_qflist,
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
end

local keys = {
  { '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = '[telescope]Search files' },
  { '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = '[telescope]Search word' },
  { '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = '[telescope]Search buffers' },
  { '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = '[telescope]Search help' },
  { '<leader>fq', "<cmd>lua require('telescope.builtin').quickfix()<cr>", desc = '[telescope]Search quickfix' },
  { '<leader>fl', "<cmd>lua require('telescope.builtin').loclist()<cr>", desc = '[telescope]Search loclist' },
  { '<leader>fp', "<cmd>lua require('telescope.builtin').commands()<cr>", desc = '[telescope]Search commands' },
  { '<leader>fo', "<cmd>lua require('telescope.builtin').oldfiles()<cr>", desc = '[telescope]Search oldfiles' },
  { '<leader>fm', "<cmd>lua require('telescope.builtin').marks()<cr>", desc = '[telescope]Search marks' },
  { '<leader>fe', "<cmd>lua require('telescope.builtin').registers()<cr>", desc = '[telescope]Search resigters' },
  { '<leader>fr', "<cmd>lua require('telescope.builtin').resume()<cr>", desc = '[telescope]Last telescope' },
  { '<leader>fk', "<cmd>lua require('telescope.builtin').keymaps()<cr>", desc = '[telescope]Search keymaps' },
  {
    '<leader>fll',
    "<cmd>lua require('telescope').extensions.lazygit.lazygit()<cr>",
    desc = '[telescope]Search git repo',
  },
  {
    '<leader>tn',
    "<cmd>lua require('telescope').extensions.notify.notify({layout_strategy='vertical'})<cr>",
    desc = '[telescope]Search notify',
  },
  { '<leader>gf', '<cmd>lua require("telescope.builtin").git_files()<cr>', desc = '[telescope]Search git files' },
  { '<leader>gb', '<cmd>lua require("telescope.builtin").git_bcommits()<cr>', desc = '[telescope]Search files' },
  { '<leader>gs', '<cmd>lua require("telescope.builtin").git_status()<cr>', desc = '[telescope]Search files' },
  -- { '<leader>fd', '<cmd>:Telescope projects<cr>', desc = '[telescope]Search projects' },
}

return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  keys = keys,
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'kdheepak/lazygit.nvim' },
    -- {
    --   'ahmedkhalf/project.nvim',
    --   config = function()
    --     require('project_nvim').setup({})
    --   end,
    -- },
    { 'nvim-telescope/telescope-symbols.nvim' },
    { 'rcarriga/nvim-notify' },
  },
  cmd = 'Telescope',
  config = setup,
}
