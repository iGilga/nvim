local M = {}

function M.init(client)
  local function buf_set_keymap(mode, lhs, rhs, desc)
    local options = { noremap = true, silent = true, desc = desc or '' }
    vim.keymap.set(mode, lhs, rhs, options)
  end

  local telescope = require('telescope.builtin')
  --  ┌──────────────────────────────────────────────────────────┐
  --  │                       diagnostics                        │
  --  └──────────────────────────────────────────────────────────┘
  buf_set_keymap('n', 'gD', vim.lsp.buf.declaration, '[lsp]Declaration')
  buf_set_keymap('n', 'gd', telescope.lsp_definitions, '[lsp]Search definitions')
  buf_set_keymap(
    'n',
    'gi',
    telescope.lsp_implementations,
    '[lsp]search implementations'
  )
  buf_set_keymap('n', 'gr', telescope.lsp_references, '[lsp]Search references')
  buf_set_keymap(
    'n',
    'gt',
    telescope.lsp_type_definitions,
    '[lsp]Search type definitions'
  )
  buf_set_keymap(
    'n',
    'ge',
    function()
      telescope.diagnostics({ bufnr = 0 })
    end,
    '[lsp]Search diagnostics current buffer'
  )
  buf_set_keymap('n', 'gs', telescope.lsp_document_symbols, '[lsp]Document symbols')
  buf_set_keymap(
    'n',
    '<leader>ge',
    telescope.diagnostics,
    '[lsp]search diagnostics'
  )
  buf_set_keymap('n', 'do', vim.diagnostic.open_float, '[lsp]Open float')
  buf_set_keymap('n', 'd[', vim.diagnostic.goto_prev, '[lsp]Next goto')
  buf_set_keymap('n', 'd]', vim.diagnostic.goto_next, '[lsp]Prev goto')

  --  ┌──────────────────────────────────────────────────────────┐
  --  │                          rename                          │
  --  └──────────────────────────────────────────────────────────┘
  buf_set_keymap('n', '<leader>gg', require('utils.rename').rename, '[lsp]Rename')

  --  ┌──────────────────────────────────────────────────────────┐
  --  │                          hover                           │
  --  └──────────────────────────────────────────────────────────┘
  buf_set_keymap('n', 'K', vim.lsp.buf.hover, '[lsp]hover')

  --  ┌──────────────────────────────────────────────────────────┐
  --  │                       code actions                       │
  --  └──────────────────────────────────────────────────────────┘
  buf_set_keymap('n', '<leader>ga', require("utils.codeaction").code_action, '[lsp]Code actions')
  buf_set_keymap(
    'v',
    '<leader>ga',
    require("utils.codeaction").range_code_action,
    '[lsp]Code actions on selected'
  )

  --  ┌──────────────────────────────────────────────────────────┐
  --  │                        formatting                        │
  --  └──────────────────────────────────────────────────────────┘
  -- buf_set_keymap('n', '<leader>f', 'vim.lsp.buf.format', '[lsp]formatting')
  buf_set_keymap('n', '<leader>f', function()
    require('conform').format({ async = true, lsp_fallback = true })
  end, '[lsp]Formatting')
  -- buf_set_keymap('v', '<leader>f', 'vim.lsp.buf.range_formatting',  'motion line' })

  -- -- signature help
  -- buf_set_keymap('n', '<C-K>', 'require("lsp_signature").signature')

  --  ┌──────────────────────────────────────────────────────────┐
  --  │                      lsp workspace                       │
  --  └──────────────────────────────────────────────────────────┘
  buf_set_keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[lsp]add ws folder')
  buf_set_keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[lsp]remove ws folder')

  buf_set_keymap(
    'n',
    '<leader>so',
    require("telescope.builtin").lsp_document_symbols,
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
