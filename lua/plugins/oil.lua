local border_style = 'solid'
function _G.get_oil_winbar()
  local dir = require('oil').get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

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
    delete_to_trash = true,
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
    win_options = {
      winbar = '%!v:lua.get_oil_winbar()'
    }
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
