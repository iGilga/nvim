local logger = require('utils.logger').Logger

function setting_keymaps(client, bufnr)
  local function map(m, l, r, desc)
    local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc or '' }
    vim.keymap.set(m, l, r, opts)
  end

  local t = require('telescope.builtin')
  --  ┌──────────────────────────────────────────────────────────┐
  --  │                       diagnostics                        │
  --  └──────────────────────────────────────────────────────────┘
  map('n', 'grr', t.lsp_references, '[lsp]Search references')
  map('n', 'gri', t.lsp_implementations, '[lsp]Search implementations')
  map('n', 'gD', vim.lsp.buf.declaration, '[lsp]Goto declaration')
  map('n', 'grd', t.lsp_definitions, '[lsp]Search definitions')
  map('n', 'grt', t.lsp_type_definitions, '[lsp]Search type definitions')
  map('n', 'g0', t.lsp_document_symbols, '[lsp]Document symbols')
  map('n', 'do', vim.diagnostic.open_float, '[lsp]Open float')
  -- search diagnostic current buffer
  map('n', 'ge', function()
    t.diagnostics({ bufnr = 0 })
  end, '[lsp]Search diagnostics current buffer')
  -- search diagnostic all buffer
  map('n', '<leader>ge', t.diagnostics, '[lsp]search diagnostics')
  -- inlay hint
  if client:supports_method('textDocument/inlayHint') then
    map('n', '<leader>h', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
      local msg = ('Inlay hint %s'):format(vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) and 'enabled' or 'disabled')
      logger.info(msg, '[LSP]')
    end, '[lsp]Toggle inlay hint')
  end
  -- rename
  map('n', '<leader>gg', require('utils.rename').rename, '[lsp]Rename')
  -- hover
  map('n', 'K', function()
    vim.lsp.buf.hover({ border = 'solid' })
  end, '[lsp]hover')
  -- code action
  map({ 'n', 'v' }, '<leader>ga', require('utils.codeaction').code_action, '[lsp]Code actions')
  -- format
  map('n', '<leader>f', function()
    require('conform').format({ async = true, lsp_fallback = true })
  end, '[lsp]Formatting')
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf
    setting_keymaps(client, bufnr)
  end,
})
