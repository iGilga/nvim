local setup = {
  auto_save_enabled = false,
  auto_restore_enabled = false,
  auto_session_create_enabled = false,
  log_level = 'error',
}

require('auto-session').setup(setup)
