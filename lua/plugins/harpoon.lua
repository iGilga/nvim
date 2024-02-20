return {
  'ThePrimeagen/harpoon',
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon_ui = require("harpoon.ui")
    local harpoon_mark = require("harpoon.mark")
    return {
      { "si", harpoon_ui.toggle_quick_menu, desc = "[harpoon] toggle quick menu" },
      { "sm", harpoon_mark.add_file,        desc = "[harpoon] add file mark" },
      { "sk", harpoon_ui.nav_next,          desc = "[harpoon] next" },
      { "sj", harpoon_ui.nav_prev,          desc = "[harpoon] prev" },
    }
  end,
  config = function()
    require('harpoon').setup()
  end,
}
