local serversRange = { 'html', 'cssls', 'vuels', 'bashls', 'jsonls', 'sumneko_lua', 'tailwindcss' }

local lspconfig = require('lspconfig')

local on_attach = function(_, bufnr)
  local function merge(...)
    return vim.tbl_deep_extend('force', ...)
  end

  local function buf_set_keymap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
      options = merge(options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  buf_set_keymap('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')
  buf_set_keymap('n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>')
  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
  -- rename
  buf_set_keymap('i', 'F3', "<cmd>lua require('utils.rename').rename()<cr>")
  buf_set_keymap('n', '<leader>gg', "<cmd>lua require('utils.rename').rename()<cr>")
  -- buf_set_keymap('n', '<leader>gg', "<cmd>Lspsaga rename<cr>")

  -- diagnostics
  buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
  buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>')
  buf_set_keymap('n', '<leader>ge', '<cmd>Telescope diagnostics bufnr=0<cr>')

  -- hover
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

  -- code actions
  buf_set_keymap('n', '<leader>ga', '<cmd>lua require("utils.codeaction").code_action()<cr>')
  buf_set_keymap('v', '<leader>ga', '<cmd>lua require("utils.codeaction").range_code_action()<cr>')

  -- buf_set_keymap('n', '<leader>ga', "<cmd>Lspsaga code_action<cr>")
  -- buf_set_keymap('v', '<leader>ga', '<cmd>Lspsaga range_code_action<cr>')
  -- formatting
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>')
  buf_set_keymap('v', '<leader>gf', '<cmd>lua vim.lsp.buf.range_formatting()<cr>')

  -- signature help
  buf_set_keymap('n', '<C-K>', '<cmd>lua require("lsp_signature").signature()<cr>')

  -- lsp workspace
  buf_set_keymap('n', '<leader>wd', '<cmd>Telescope diagnostics<cr>')
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

capabilities.textDocument.completion.completionItem.snippetSupport = true

require('utils.sign')

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
  jsonls = {
    settings = {
      json = {
        schemas = {
          {
            fileMatch = { 'pacakge.json' },
            url = 'https://json.schemastore.org/package.json',
          },
          {
            fileMatch = { '.eslintrc' },
            url = 'https://json.schemastore.org/eslintrc.json',
          },
          {
            fileMatch = { 'docker-compose.yml' },
            url = 'https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json',
          },
        },
      },
    },
  },
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
