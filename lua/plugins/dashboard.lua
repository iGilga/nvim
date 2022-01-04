local g = vim.g

g.dashboard_default_executive = 'telescope'

g.dashboard_session_directory = vim.fn.stdpath('data') .. '/sessions'

g.dashboard_custom_header = {
 ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
 ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
 ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
 ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
 ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
 ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

g.dashboard_custom_section = {
  find_file = {
    description = { ' ' .. ' Find File           <leader>ff' },
    command = 'Telescope find_files',
  },
  file_explorer = {
    description = { ' ' .. ' File Manager        <C-t>     ' },
    command = 'NnnPicker',
  },
  find_string = {
    description = { ' ' .. ' Grep String         <leader>fs' },
    command = 'Telescope grep_string',
  },
  last_session = {
    description = { ' ' .. ' Load Session        <leader>sl' },
    command = 'Telescope session-lens search_session',
  },
}
