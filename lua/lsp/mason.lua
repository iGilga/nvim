require('mason').setup()
local mason_lsp = require('mason-lspconfig')
local mason_nullls = require('mason-null-ls')
local lsp = require('lspconfig')

local border = require('config').border
local logger = require('utils.logger').Logger
local defaultConfig = require('lsp.servers.default')

mason_lsp.setup({
  ensure_installed = { 'sumneko_lua', 'tsserver' },
})

mason_nullls.setup({
  ensure_installed = { 'eslint_d', 'stylua', 'prettierd' },
  automatic_installation = false,
  automatic_setup = true, -- Recommended, but optional
})

local server = {
  sumneko_lua = {
    cmd = { 'lua-language-server' },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        diagnostics = {
          enable = true,
          globals = {
            'vim',
            'describe',
            'it',
            'before_each',
            'after_each',
            'teardown',
            'pending',
            'use',
          },
          workspace = {
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  },
}

mason_lsp.setup_handlers({
  function(server_name)
    local opts = valhalla.merge(defaultConfig, server[server_name] or {})
    lsp[server_name].setup(opts)
  end,
})

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

local nullls = require('null-ls')
local command_resolver = require('null-ls.helpers.command_resolver')
local code_actions = nullls.builtins.code_actions
local diagnostics = nullls.builtins.diagnostics
local formatting = nullls.builtins.formatting

local sources = {
  code_actions.eslint_d.with({
    condition = has_eslint_config,
    dynamic_command = command_resolver.from_yarn_pnp(),
  }),
  -- code_actions.gitsigns,
  diagnostics.eslint_d.with({
    -- diagnostics_format = '[#{s}] #{m}\n(#{c})',
    diagnostics_format = '#{m}\n(#{c})',
    condition = has_eslint_config,
    dynamic_command = command_resolver.from_yarn_pnp(),
  }),
  formatting.prettierd.with({
    -- condition = function()
    --   return not has_prettier_config
    -- end,
    dynamic_command = command_resolver.from_yarn_pnp(),
  }),
  formatting.stylua.with({
    extra_args = { '--config-path', vim.fn.expand('~/.config/nvim/lintercfg/stylua.toml') },
  }),
}

nullls.setup({
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
})

mason_nullls.setup_handlers()

local lsp = vim.lsp

lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, {
  border = border,
})

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, {
  border = border,
})

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  -- code_action_icon = signs.LightBulb,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

lsp.handlers['textDocument/formatting'] = function(_, result, ctx)
  if result and not vim.tbl_isempty(result) then
    local client = lsp.get_client_by_id(ctx.client_id)
    lsp.util.apply_text_edits(result, ctx.bufnr, client.offset_encoding)
    logger.info('Formatting done', ('[LSP][%s]'):format(client.name))
  end
end

local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end
