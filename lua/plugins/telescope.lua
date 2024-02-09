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
      path_display = { truncate = 3 },
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
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      -- ['ui-select'] = {
      --   require('telescope.themes').get_dropdown({
      --     initial_mode = 'normal',
      --     borderchars = { ' ' },
      --   }),
      -- },
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
  -- telescope.load_extension('ui-select')

  local ok, _ = pcall(require, 'notify')
  if ok then
    telescope.load_extension('notify')
  end

  local ok, _ = pcall(require, 'harpoon')
  if ok then
    telescope.load_extension('harpoon')
  end
  local ok, _ = pcall(require, 'lazygit')
  if ok then
    telescope.load_extension('lazygit')
  end
end

local keys = function()
  local ts = require('telescope')
  local tsb = require('telescope.builtin')
  local keys = {
    { '<leader>ff', tsb.find_files,                desc = '[telescope]Search files' },
    { '<leader>fg', tsb.live_grep,                 desc = '[telescope]Search word' },
    { '<leader>fb', tsb.buffers,                   desc = '[telescope]Search buffers' },
    { '<leader>fh', tsb.help_tags,                 desc = '[telescope]Search help' },
    { '<leader>fq', tsb.quickfix,                  desc = '[telescope]Search quickfix' },
    { '<leader>fl', tsb.loclist,                   desc = '[telescope]Search loclist' },
    { '<leader>fp', tsb.commands,                  desc = '[telescope]Search commands' },
    { '<leader>fo', tsb.oldfiles,                  desc = '[telescope]Search oldfiles' },
    { '<leader>fm', tsb.marks,                     desc = '[telescope]Search marks' },
    { '<leader>fe', tsb.registers,                 desc = '[telescope]Search resigters' },
    { '<leader>fr', tsb.resume,                    desc = '[telescope]Last telescope' },
    { '<leader>fk', tsb.keymaps,                   desc = '[telescope]Search keymaps' },
    { '<leader>fw', tsb.current_buffer_fuzzy_find, desc = '[telescope]Search current buffer', },
    { '<leader>gf', tsb.git_files,                 desc = '[telescope]Git files' },
    { '<leader>gb', tsb.git_bcommits,              desc = '[telescope]Git bcommits' },
    { '<leader>gs', tsb.git_status,                desc = '[telescope]Git status' },
  }
  if ts.extensions.notify then
    table.insert(keys, {
      '<leader>tn',
      function()
        ts.extensions.notify.notify({ layout_strategy = 'vertical' })
      end,
      desc = '[telescope]Search notify',
    })
  end
  return keys
end

return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  keys = keys,
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
