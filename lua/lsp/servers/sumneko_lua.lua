local defaultProvider = require('lsp.servers.default')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local M = {}

M.settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = runtime_path,
    },
    diagnostics = {
      globals = { 'vim' },
    },
    -- workspace = {
    --   library = vim.api.nvim_get_runtime_file("", true),
    -- },
    telemetry = {
      enable = false,
    },
  },
}

return M
