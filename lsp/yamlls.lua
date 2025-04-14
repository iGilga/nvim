return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    single_file_support = true,
  },
}
