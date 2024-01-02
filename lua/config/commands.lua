vim.api.nvim_create_user_command('Format', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Format file with LSP' })

vim.api.nvim_create_user_command('DiagnosticToggle', function()
  local config = vim.diagnostic.config
  local vt = config().virtual_text
  config({
    virtual_text = not vt,
    underline = not vt,
    -- signs = not vt,
  })
end, { desc = 'toggle diagnostic' })

local isAbs = false
vim.api.nvim_create_user_command('AbsToggle', function()
  if isAbs then
    vim.o.statuscolumn = '%s %r'
    isAbs = false
  else
    vim.o.statuscolumn = '%s %l %r'
    isAbs = true
  end
end, {})

local isEmmet = true
local emmetConfig
vim.api.nvim_create_user_command('Emmet', function()
  if isEmmet then
    local clients = vim.lsp.get_active_clients()
    for _, client in pairs(clients) do
      print(client.name)
      if client.name == 'emmet_language_server' then
        emmetConfig = client.config
        vim.lsp.stop_client(client.id)
        isEmmet = false
      end
    end
  else
    vim.lsp.start(emmetConfig)
    isEmmet = true
  end
end, {})
