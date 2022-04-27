local nullls = require('null-ls')
-- local defaultAttach = require('lsp.servers.default').on_attach

local has_eslint_config = function(utils)
  local files = {
    '.eslintrc',
    '.eslintrc.json',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    -- 'package.json',
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

-- local function on_attachCustom(client)
--   if client.resolved_capabilities.document_formatting then
--     vim.cmd([[
--             augroup LspFormatting
--                 autocmd! * <buffer>
--                 autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
--             augroup END
--             ]])
--   end
-- end

local setup = {
  -- on_attach = defaultAttach,
  sources = sources,
}

nullls.setup(setup)
