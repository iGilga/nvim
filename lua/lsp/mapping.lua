local u = require('utils')

local M = {}

function M.init(client, bufnr)
  local function buf_set_keymap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
      options = u.merge(options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
  end
  -- diagnostics
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  buf_set_keymap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
  buf_set_keymap('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')
  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
  buf_set_keymap('n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>')
  buf_set_keymap('n', 'ge', '<cmd>lua require("telescope.builtin").diagnostics({bufnr=0})<cr>')
  buf_set_keymap('n', '<leader>ge', '<cmd>lua require("telescope.builtin").diagnostics()<cr>')
  buf_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
  buf_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<cr>')

  -- rename
  buf_set_keymap('n', '<leader>gg', "<cmd>lua require('utils.rename').rename()<cr>")

  -- hover
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

  -- code actions
  buf_set_keymap('n', '<leader>ga', '<cmd>lua require("utils.codeaction").code_action()<cr>')
  buf_set_keymap('v', '<leader>ga', '<cmd>lua require("utils.codeaction").range_code_action()<cr>')

  -- formatting
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>')
  buf_set_keymap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<cr>')

  -- -- signature help
  -- buf_set_keymap('n', '<C-K>', '<cmd>lua require("lsp_signature").signature()<cr>')

  -- lsp workspace
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')

  buf_set_keymap('n', '<leader>so', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>')
  if client.name == 'eslint' then
    buf_set_keymap('n', '<leader>efa', ':EslintFixAll')
  end
  -- if client.name == 'tsserver' then
  --   buf_set_keymap('n', '<leader>gr',':TSLspRenameFile<cr>')
  --   buf_set_keymap('n', '<leader>go',':TSLspOrganize<cr>')
  --   buf_set_keymap('n', '<leader>gi',':TSLspImportAll<cr>')
  -- end
  -- print('Loaded mapping for', client.name)
end

return M
