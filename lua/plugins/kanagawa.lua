local function setup()
  local colors = {
    palette = {
      bg0 = '#2A2A37',
      bg1 = '#1b1b24',    --darkly
      bg2 = '#181820',    --darkly
      green1 = '#52674a', --darkly
      grey1 = '#22222C',
      grey2 = '#252530',
      grey3 = '#282834',
      grey4 = '#2B2B37',
      grey5 = '#2E2E3B',
      grey6 = '#31313F',
      grey7 = '#343443',
      dark1 = '#1D1D26',
      dark2 = '#1B1B23',
      dark3 = '#191920',
    },
    theme = {
      all = {
        ui = {
          bg_gutter = 'none',
        },
      },
    },
  }

  local function highlights(colors)
    local hls = {}
    for plugin, enabled in pairs({
      alpha = true,
      cmp = true,
      hop = true,
      ibl = true,
      illuminate = true,
      marks = true,
      notify = true,
      nui = true,
      telescope = true,
      todo = true,
    }) do
      if enabled then
        local m = require('theme.plugins.' .. plugin)
        hls = vim.tbl_deep_extend('force', hls, m.hl(colors))
      end
    end
    return hls
  end

  local setup = {
    globalStatus = true,
    overrides = highlights,
    colors = colors,
    theme = 'wave',
  }
  local kanagawa = require('kanagawa')
  kanagawa.setup(setup)
  vim.api.nvim_command('colorscheme kanagawa')
  -- kanagawa.load("wave")
  -- vim.api.nvim_command(('colorscheme %s'):format(name))
end

return { {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  cmd = 'KanagawaCompile',
  -- build = 'KanagawaCompile',
  config = setup,
}, {
  'nvim-tree/nvim-web-devicons',
  opts = {
    color_icons = false
  }
}
}
