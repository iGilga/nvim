local M = {}

function M.init(client, bufnr)
  local function buf_set_keymap(mode, lhs, rhs, desc)
    local options = { noremap = true, silent = true, desc = desc or '' }
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
  end
  -- diagnostics
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', '[lsp] declaration')
  buf_set_keymap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', '[lsp]search definitions')
  buf_set_keymap(
    'n',
    'gi',
    '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>',
    '[lsp]search implementations'
  )
  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', '[lsp]search references')
  buf_set_keymap(
    'n',
    'gt',
    '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>',
    '[lsp]search type definitions'
  )
  buf_set_keymap(
    'n',
    'ge',
    '<cmd>lua require("telescope.builtin").diagnostics({bufnr=0})<cr>',
    '[lsp]search diagnostics current buffer'
  )
  buf_set_keymap(
    'n',
    '<leader>ge',
    '<cmd>lua require("telescope.builtin").diagnostics()<cr>',
    '[lsp]search diagnostics'
  )
  buf_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<cr>', '[lsp]next goto')
  buf_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<cr>', '[lsp]prev goto')

  -- rename
  buf_set_keymap('n', '<leader>gg', "<cmd>lua require('utils.rename').rename()<cr>", '[lsp]rename')

  -- hover
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', '[lsp]hover')

  -- code actions
  buf_set_keymap('n', '<leader>ga', '<cmd>lua require("utils.codeaction").code_action()<cr>', '[lsp]code actions')
  buf_set_keymap(
    'v',
    '<leader>ga',
    '<cmd>lua require("utils.codeaction").range_code_action()<cr>',
    '[lsp]code actions on selected'
  )

  -- formatting
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async=true})<cr>', '[lsp]formatting')
  -- buf_set_keymap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<cr>',  'motion line' })

  -- -- signature help
  -- buf_set_keymap('n', '<C-K>', '<cmd>lua require("lsp_signature").signature()<cr>')

  -- lsp workspace
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', '[lsp]add ws folder')
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', '[lsp]remove ws folder')

  buf_set_keymap(
    'n',
    '<leader>so',
    '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>',
    '[lsp]search document symbols'
  )
  if client.name == 'eslint' then
    buf_set_keymap('n', '<leader>efa', ':EslintFixAll', '[eslint]fix all')
  end
  -- if client.name == 'tsserver' then
  --   buf_set_keymap('n', '<leader>gr',':TSLspRenameFile<cr>')
  --   buf_set_keymap('n', '<leader>go',':TSLspOrganize<cr>')
  --   buf_set_keymap('n', '<leader>gi',':TSLspImportAll<cr>')
  -- end
end

return M
