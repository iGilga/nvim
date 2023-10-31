local function setup()
  local nullls = require('null-ls')
  local mason_nullls = require('mason-null-ls')
  local code_actions = nullls.builtins.code_actions
  local diagnostics = nullls.builtins.diagnostics
  local formatting = nullls.builtins.formatting

  --  ┌──────────────────────────────────────────────────────────┐
  --  │ Settings null-ls                                         │
  --  └──────────────────────────────────────────────────────────┘
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
    code_actions.eslint.with({
      condition = has_eslint_config,
      only_local = 'node_modules/.bin',
    }),
    code_actions.gitsigns,
    diagnostics.eslint.with({
      condition = has_eslint_config,
      only_local = 'node_modules/.bin',
    }),
    diagnostics.yamllint.with({}),
    diagnostics.shellcheck,
    formatting.prettierd,
    formatting.shfmt.with({
      extra_args = { '-sr', '-i', '2', '-ci' },
    }),
    formatting.xmlformat,
  }

  local augroup = vim.api.nvim_create_augroup('NullFormatting', { clear = true })

  local setup = {
    sources = sources,
    on_attach = function(client, bufnr)
      if not valhalla.isClientFormat(client.name) then
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            desc = 'null-ls autoformat on save',
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end
    end,
  }

  nullls.setup(setup)
  --  ┌──────────────────────────────────────────────────────────┐
  --  │ Settings null-ls for mason                               │
  --  └──────────────────────────────────────────────────────────┘
  mason_nullls.setup({
    ensure_installed = { 'prettierd', 'shfmt' },
    -- automatic_installation = true,
    automatic_setup = true, -- Recommended, but optional
  })
end

return {
  'nvimtools/none-ls.nvim',
  event = 'BufReadPre',
  dependencies = {},
  config = setup,
  enabled = false,
}
