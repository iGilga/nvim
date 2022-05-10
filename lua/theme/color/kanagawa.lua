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

M.groups = {
  NotifyINFOBorder = { fg = M.colors.green },
  NotifyINFOIcon = { fg = M.colors.green },
  NotifyINFOTitle = { fg = M.colors.green },
  NotifyINFOBody = { fg = M.colors.white },
  NotifyWARNBorder = { fg = M.colors.yellow },
  NotifyWARNIcon = { fg = M.colors.yellow },
  NotifyWARNTitle = { fg = M.colors.yellow },
  NotifyWARNBody = { fg = M.colors.white },
  NotifyERRORBorder = { fg = M.colors.red },
  NotifyERRORIcon = { fg = M.colors.red },
  NotifyERRORTitle = { fg = M.colors.red },
  NotifyERRORBody = { fg = M.colors.white },
  NotifyTRACEBorder = { fg = M.colors.purple },
  NotifyTRACEIcon = { fg = M.colors.purple },
  NotifyTRACETitle = { fg = M.colors.purple },
  NotifyTRACEBody = { fg = M.colors.white },
  AlphaHeader = { fg = M.colors.green },
  AlphaShortcuts = { fg = M.colors.bg, bg = M.colors.green },
  AlphaButton = { fg = M.colors.white },
  AlphaIcon = { fg = M.colors.green },
}

return M
