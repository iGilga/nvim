local serversRange = { 'html', 'cssls', 'denols', 'vuels', 'bashls', 'yamlls', 'jsonls', 'sumneko_lua' }

local lspconfig = require('lspconfig')
-- local coq = require("coq")

local on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true }

  function buf_map(bufnr, mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
      options = merge(options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
  end

  function merge(...)
    return vim.tbl_deep_extend('force', ...)
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_map(bufnr, 'n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
  buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  buf_map(bufnr, 'n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')
  buf_map(bufnr, 'n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>')
  buf_map(bufnr, 'n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
  -- buf_map(bufnr, 'n', 'gn', '<cmd>lua require("cosmic-ui").rename()<cr>')

  -- diagnostics
  buf_map(bufnr, 'n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
  buf_map(bufnr, 'n', ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  buf_map(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>')
  buf_map(bufnr, 'n', '<leader>ge', '<cmd>Telescope diagnostics bufnr=0<cr>')

  -- hover
  buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

  -- code actions
  -- buf_map(bufnr, 'n', '<leader>ga', '<cmd>lua require("cosmic-ui").code_actions()<cr>')
  -- buf_map(bufnr, 'v', '<leader>ga', '<cmd>lua require("cosmic-ui").range_code_actions()<cr>')

  -- formatting
  buf_map(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>')
  buf_map(bufnr, 'v', '<leader>gf', '<cmd>lua vim.lsp.buf.range_formatting()<cr>')

  -- signature help
  buf_map(bufnr, 'n', '<C-K>', '<cmd>lua require("lsp_signature").signature()<cr>')

  -- lsp workspace
  buf_map(bufnr, 'n', '<leader>wd', '<cmd>Telescope diagnostics<cr>')
  buf_map(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
  buf_map(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
  -- buf_map(
  --   bufnr,
  --   'n',
  --   '<leader>wl',
  --   '<cmd>lua require("cosmic.utils.logger"):log(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>'
  -- )
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local serverConfig = {
  sumneko_lua = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  lua = {},
}

local function setup_servers()
  for _, server in pairs(serversRange) do
    lspconfig[server].setup(serverConfig[server] or {
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
end

setup_servers()
