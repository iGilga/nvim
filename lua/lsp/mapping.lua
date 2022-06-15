local u = require('utils')

local M = {}

function M.init(client, bufnr)
  local function buf_set_keymap(mode, lhs, rhs, desc)
    local options = { noremap = true, silent = true, desc = desc or '' }
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
  end
  -- diagnostics
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = '[lsp] declaration' })
  buf_set_keymap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', { desc = 'search definitions' })
  buf_set_keymap('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', { desc = 'search implementations' })
  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', { desc = 'search references' })
  buf_set_keymap(
    'n',
    'gt',
    '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>',
    { desc = 'search type definitions' }
  )
  buf_set_keymap(
    'n',
    'ge',
    '<cmd>lua require("telescope.builtin").diagnostics({bufnr=0})<cr>',
    { desc = 'search diagnostics current buffer' }
  )
  buf_set_keymap('n', '<leader>ge', '<cmd>lua require("telescope.builtin").diagnostics()<cr>', { desc = 'search diagnostics' })
  buf_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'next goto' })
  buf_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'prev goto' })

  -- rename
  buf_set_keymap('n', '<leader>gg', "<cmd>lua require('utils.rename').rename()<cr>", { desc = 'rename' })

  -- hover
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'hover' })

  -- code actions
  buf_set_keymap('n', '<leader>ga', '<cmd>lua require("utils.codeaction").code_action()<cr>', { desc = 'code actions' })
  buf_set_keymap(
    'v',
    '<leader>ga',
    '<cmd>lua require("utils.codeaction").range_code_action()<cr>',
    { desc = 'code actions on selected' }
  )

  -- formatting
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', { desc = 'formatting' })
  -- buf_set_keymap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', { desc = 'motion line' })

  -- -- signature help
  -- buf_set_keymap('n', '<C-K>', '<cmd>lua require("lsp_signature").signature()<cr>')

  -- lsp workspace
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', { desc = 'add ws folder' })
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', { desc = 'remove ws folder' })

  buf_set_keymap(
    'n',
    '<leader>so',
    '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>',
    { desc = 'search document symbols' }
  )
  if client.name == 'eslint' then
    buf_set_keymap('n', '<leader>efa', ':EslintFixAll', { desc = '[eslint] fix all' })
  end
  -- if client.name == 'tsserver' then
  --   buf_set_keymap('n', '<leader>gr',':TSLspRenameFile<cr>')
  --   buf_set_keymap('n', '<leader>go',':TSLspOrganize<cr>')
  --   buf_set_keymap('n', '<leader>gi',':TSLspImportAll<cr>')
  -- end
end

return M
