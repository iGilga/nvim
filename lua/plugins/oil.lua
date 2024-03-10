local border_style = 'solid'
local keys = function()
  local oil = require('oil')
  return
  {
    {
      '<leader>m',
      function()
        if vim.bo.filetype == 'oil' then
          oil.close()
        else
          oil.open()
        end
      end,
      desc = 'Toogle oil(File navigation)',
    },

  }
end
return {
  'stevearc/oil.nvim',
  keys = keys,
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps_help = {
      border = border_style,
    },
    float = {
      border = border_style,
    },
    preview = {
      border = border_style,
    },
    progress = {
      border = border_style,
    },
    ssh = {
      border = border_style
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
