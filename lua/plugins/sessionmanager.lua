local function setup()
  local setup = {
    autosave_last_session = false,
  }
  require('session_manager').setup(setup)
end

local keys = {
  -- { '<leader>sl', '<cmd>SessionManager! load_last_session<cr>', desc = 'Load last session'},
  { '<leader>oo', '<cmd>SessionManager! save_current_session<cr>', desc = 'Save this session' },
  { '<leader>od', '<cmd>SessionManager! delete_session<cr>', desc = 'Delete session' },
  { '<leader>sf', '<cmd>SessionManager! load_session<cr>', desc = 'Search sessions' },
  { '<F4>', '<cmd>SessionManager! load_current_dir_session<cr>', desc = 'Load current directory session' },
}
return {
  'Shatur/neovim-session-manager',
  cmd = 'SessionManager',
  keys = keys,
  event = 'BufWritePost',
  config = setup,
}
