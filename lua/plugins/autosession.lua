local setup = {
  auto_save_enabled = false,
  auto_restore_enabled = false,
  auto_session_create_enabled = false,
  log_level = 'info',
  -- auto_session_suppress_dirs = {'~/', '~/project'}
}

require('auto-session').setup(setup)
