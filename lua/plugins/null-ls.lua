local function setup()
  local nullls = require('null-ls')
  local mason_nullls = require('mason-null-ls')
  local command_resolver = require('null-ls.helpers.command_resolver')
  local code_actions = nullls.builtins.code_actions
  local diagnostics = nullls.builtins.diagnostics
  local formatting = nullls.builtins.formatting

  local has_eslint_config = function(utils)
    local files = {
      '.eslintrc',
      '.eslintrc.json',
      '.eslintrc.js',
      '.eslintrc.cjs',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      'package.json',
    }
    return utils.has_file(files) or utils.root_has_file(files)
  end

  local sources = {
    code_actions.eslint_d.with({
      condition = has_eslint_config,
      -- prefer_local = 'node_modules/.bin',
      dynamic_command = command_resolver.from_yarn_pnp(),
    }),
    code_actions.gitsigns,
    -- diagnostics.eslint_d.with({
    --   -- diagnostics_format = '[#{s}] #{m}\n(#{c})',
    --   diagnostics_format = '#{m}\n(#{c})',
    --   condition = has_eslint_config,
    --   -- prefer_local = 'node_modules/.bin',
    --   dynamic_command = command_resolver.from_yarn_pnp(),
    -- }),
    diagnostics.yamllint.with({
      -- extra_args = { '-d', 'ignore:', 'openra/mods/' },
    }),
    diagnostics.shellcheck,
    formatting.prettierd.with({
      -- condition = function()
      --   return not has_prettier_config
      -- end,
      dynamic_command = command_resolver.from_yarn_pnp(),
    }),
    formatting.shfmt.with({
      extra_args = { '-sr', '-i', '2', '-ci' },
    }),
    formatting.stylua.with({
      -- extra_args = { '--config-path', vim.fn.expand('~/.config/nvim/lintercfg/stylua.toml') },
    }),
  }

  -- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

  local setup = {
    -- debug = true,
    sources = sources,
    on_attach = function(client, bufnr)
      -- if u.isClientFormat(client.name) then
      --   print(client.name)
      --   client.server_capabilities.documentFormattingProvider = false
      --   client.server_capabilities.documentRangeFormattingProvider = false
      -- end
      if client.supports_method('textDocument/formatting') then
        -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_buf_set_keymap(
          bufnr,
          'n',
          '<leader>f',
          '<cmd>lua vim.lsp.buf.format({async=true})<cr>',
          { desc = '[lsp]formatting' }
        )
      end
    end,
  }

  --  ┌──────────────────────────────────────────────────────────┐
  --  │ Settings null-ls                                         │
  --  └──────────────────────────────────────────────────────────┘
  mason_nullls.setup({
    ensure_installed = { 'eslint_d', 'stylua', 'prettierd', 'shfmt', 'gitsigns' },
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
  })

  nullls.setup(setup)

  mason_nullls.setup_handlers()
end

return
{
  'jose-elias-alvarez/null-ls.nvim',
  event = 'BufReadPre',
  dependencies = {
    { 'jayp0521/mason-null-ls.nvim' },
  },
  config = setup,
}
