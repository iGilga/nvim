local colors = require('kanagawa.colors').setup({ theme = 'wave' })

local palettes = colors.palette

local customColors = {
  white = palettes.fujiWhite,
  black = palettes.oldWhite,
  bg = palettes.sumiInk1,
  bg_dark = palettes.sumiInk0,
  bg_light = palettes.sumiInk2,
  red = palettes.autumnRed,
  blue = palettes.dragonBlue,
  green = palettes.autumnGreen,
  yellow = palettes.autumnYellow,
  purple = palettes.sakuraPink,
  gray = palettes.sumiInk4,
  selection = palettes.sumiInk3,
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
}

return valhalla.merge(palettes, customColors)
