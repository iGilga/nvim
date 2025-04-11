local M = {}
function M.hl(colors)
  return {
    CursorLineNr = { bg = colors.palette.sumiInk5 },
    CursorLineSign = { bg = colors.palette.sumiInk5 },
    Pmenu = { bg = colors.palette.sumiInk1 },
    PmenuSel = { bg = colors.palette.sumiInk5 },
    PmenuThumb = { bg = colors.palette.sumiInk5 },
    PmenuSbar = { bg = colors.palette.sumiInk4 },
    PmenuExtra = { bg = colors.palette.sumiInk1, fg = colors.fujiGray },
    ['@string.special.url'] = { undercurl = false, underline = true },
  }
end

return M
