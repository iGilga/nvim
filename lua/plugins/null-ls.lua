local nullls = require('null-ls')
local code_actions = nullls.builtins.code_actions
local diagnostics = nullls.builtins.diagnostics
local formatting = nullls.builtins.formatting

-- local has_eslint_config = function(utils)
--   local files = {
--     '.eslintrc',
--     '.eslintrc.json',
--     '.eslintrc.js',
--     '.eslintrc.cjs',
--     '.eslintrc.yaml',
--     '.eslintrc.yml',
--   }
--   return utils.has_file(files) or utils.root_has_file(files)
-- end

local sources = {
  -- code_actions.eslint_d.with({
  --   condition = has_eslint_config,
  --   prefer_local = 'node_modules/.bin',
  -- }),
  code_actions.gitsigns,
  -- diagnostics.eslint_d.with({
  --   condition = has_eslint_config,
  --   prefer_local = 'node_modules/.bin',
  -- }),
  diagnostics.yamllint,
  diagnostics.shellcheck,
  -- formatting.eslint_d.with({
  --   condition = has_eslint_config,
  --   prefer_local = 'node_modules/.bin',
  -- }),
  formatting.prettierd.with({
    -- condition = function()
    --   return not has_prettier_config
    -- end,
  }),
  formatting.shfmt.with({
    extra_args = { '-sr', '-i', '2', '-ci' },
  }),
  formatting.stylua.with({
    extra_args = { '--config-path', vim.fn.expand('~/.config/nvim/lintercfg/stylua.toml') },
  }),
  formatting.taplo,
}

-- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local function onAttachCustom(client, bufnr)
  vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting, {})
  -- if client.supports_method('textDocument/formatting') then
  -- if client.resolved_capabilities.document_formatting then
  --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --   vim.api.nvim_create_autocmd('BufWritePre', {
  --     group = augroup,
  --     buffer = bufnr,
  --     -- on 0.8, you should use vim.lsp.buf.format instead
  --     callback = vim.lsp.buf.formatting,
  --   })
  -- end
end

local setup = {
  debug = false,
  on_attach = onAttachCustom,
  sources = sources,
}

nullls.setup(setup)
