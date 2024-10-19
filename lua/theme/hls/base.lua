local M = {}
function M.hl(colors)
  return {
    CursorLineNr = { bg = colors.palette.sumiInk5 },
    CursorLineSign = { bg = colors.palette.sumiInk5 },
    -- NormalFloat = { fg = colors.palette.fujiWhite, bg = colors.palette.dark3 },
    -- FloatBorder = { fg = colors.palette.sumiInk4, bg = colors.palette.dark3 },
    -- CBorder = { fg = colors.palette.autumnGreen, bg = colors.palette.autumnGreen },
    -- TSDefinitionUsage = { fg = C.bg, bg = C.green },
    -- TSDefinition = { fg = C.bg, bg = C.yellow },
  }
end

return M
