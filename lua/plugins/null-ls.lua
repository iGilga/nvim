local nullls = require('null-ls')

local has_eslint_config = function(utils)
  return utils.root_has_file('.eslintrc')
    or utils.root_has_file('.eslintrc.json')
    or utils.root_has_file('.eslintrc.js')
    or utils.root_has_file('package.json')
    or utils.root_has_file('.eslintrc.cjs')
    or utils.root_has_file('.eslintrc.yaml')
    or utils.root_has_file('.eslintrc.yml')
end

local sources = {
  nullls.builtins.code_actions.eslint_d.with({
    condition = has_eslint_config,
  }),
  nullls.builtins.diagnostics.eslint_d.with({
    condition = has_eslint_config,
  }),
  nullls.builtins.formatting.eslint_d.with({
    condition = has_eslint_config,
  }),
  nullls.builtins.code_actions.gitsigns,
  nullls.builtins.formatting.prettierd,
  nullls.builtins.formatting.stylua.with({
    extra_args = { '--config-path', vim.fn.expand('~/.config/stylua/stylua.toml') },
  }),
}

-- local denofmt = {
--   method = nullls.methods.FORMATTING,
--   filetypes = {"javascipt, javascriptreact, javascript.jsx"},
--   generator = nullls.formatter({
--     command = "deno",
--     --args = { "fmt", "-"},
--     to_stdin = true
--   }),
-- }

local setup = {
  sources = sources,
}

nullls.setup(setup)
