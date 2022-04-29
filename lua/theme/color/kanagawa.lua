local theme = require('kanagawa.colors').setup()

local M = {}

M.kanagawa = theme

M.colors = {
  white = theme.fujiWhite,
  black = theme.oldWhite,
  bg = theme.sumiInk1,
  bg_dark = theme.sumiInk0,
  bg_highlight = theme.sumiInk2,
  red = theme.autumnRed,
  blue = theme.dragonBlue,
  green = theme.autumnGreen,
  yellow = theme.autumnYellow,
  purple = theme.sakuraPink,
  gray = theme.sumiInk4,
}

return M
