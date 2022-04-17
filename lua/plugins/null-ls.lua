local nullls = require('null-ls')

local has_eslint_config = function(utils)
  local files = {
    '.eslintrc',
    '.eslintrc.json',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
  }
  return utils.has_file(files) or utils.root_has_file(files)
end

local sources = {
  nullls.builtins.code_actions.eslint_d.with({
    condition = has_eslint_config,
    prefer_local = 'node_modules/.bin',
  }),
  nullls.builtins.diagnostics.eslint_d.with({
    condition = has_eslint_config,
    prefer_local = 'node_modules/.bin',
  }),
  nullls.builtins.formatting.eslint_d.with({
    condition = has_eslint_config,
    prefer_local = 'node_modules/.bin',
  }),
  nullls.builtins.code_actions.gitsigns,
  nullls.builtins.formatting.prettierd,
  nullls.builtins.formatting.stylua.with({
    extra_args = { '--config-path', vim.fn.expand('~/.config/stylua/stylua.toml') },
  }),
}

local setup = {
  sources = sources,
}

nullls.setup(setup)
