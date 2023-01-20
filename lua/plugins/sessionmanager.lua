local function setup()
  local setup = {
    autosave_last_session = false,
  }

  require('session_manager').setup(setup)
end

return {
  'Shatur/neovim-session-manager',
  cmd = 'SessionManager',
  event = 'BufWritePost',
  config = setup,
}
