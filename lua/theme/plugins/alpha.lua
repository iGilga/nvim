local M = {}

function M.hl(colors)
  return {
    AlphaHeader = { fg = colors.palette.autumnGreen },
    AlphaShortcuts = { fg = colors.palette.sumiInk1, bg = colors.palette.autumnGreen },
    AlphaButton = { fg = colors.palette.fujiWhite },
    AlphaIcon = { fg = colors.palette.autumnGreen },
  }
end

return M
