local u = require('utils')
local defaultOnAttach = require('lsp.servers.default').on_attach
local config = require('config')
local M = {}

-- M.init_options = require('nvim-lsp-ts-utils').init_options

function M.on_attach(client, bufnr)
  defaultOnAttach(client, bufnr)

  -- local tsUtils = require('nvim-lsp-ts-utils')
  --
  -- tsUtils.setup({
  --   debug = false,
  --   disable_commands = false,
  --   enable_import_on_completion = true,
  --
  --   -- import all
  --   import_all_timeout = 5000, -- ms
  --   import_all_priorities = {
  --     buffers = 4, -- loaded buffer names
  --     buffer_content = 3, -- loaded buffer content
  --     local_files = 2, -- git files or files with relative path markers
  --     same_file = 1, -- add to existing import statement
  --   },
  --   import_all_scan_buffers = 100,
  --   import_all_select_source = false,
  --
  --   -- inlay hints
  --   auto_inlay_hints = true,
  --   inlay_hints_highlight = 'Comment',
  --
  --   -- update imports on file move
  --   update_imports_on_move = true,
  --   require_confirmation_on_move = false,
  --   watch_dir = nil,
  --
  --   -- filter diagnostics
  --   filter_out_diagnostics_by_severity = {},
  --   filter_out_diagnostics_by_code = {},
  -- })
  --
  -- tsUtils.setup_client(client)
end

return M