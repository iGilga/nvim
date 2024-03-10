return {
  'folke/trouble.nvim',
  cmd = { 'TroubleToggle', 'Trouble' },
  opts = { use_diagnostic_signs = true },
  keys = function()
    local tb = require('trouble')
    return {
      { '<leader>xx', tb.toggle },
      { '<leader>xd', function() tb.toggle('document_diagnostics') end,  desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xw', function() tb.toggle('workspace_diagnostics') end, desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xl', function() tb.toggle('loclist') end,               desc = 'Location List (Trouble)' },
      { '<leader>xq', function() tb.toggle('quickfix') end,              desc = 'Quickfix List (Trouble)' },
      { '<leader>xr', function() tb.toggle('lsp_references') end,        desc = 'Refetence List (Trouble)' },
      {
        '[q',
        function()
          if tb.is_open() then
            tb.previous({ skip_groups = true, jump = true })
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
      {
        ']q',
        function()
          if tb.is_open() then
            tb.next({ skip_groups = true, jump = true })
          end
        end,
        desc = 'Next trouble/quickfix item',
      },
    }
  end
}
