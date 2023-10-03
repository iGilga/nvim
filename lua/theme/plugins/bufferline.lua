local M = {}

function M.hl(colors)
  local p = colors.palette
  local dark, normal = p.sumiInk0, p.sumiInk1
  return {
    BufferLineFill = { fg = dark, bg = dark },
    BufferLineBackground = { fg = p.fujiGray, bg = dark },
    BufferLineBufferVisible = { fg = p.oldWhite, bg = normal },
    BufferLineBufferSelected = { fg = p.oldWhite, bg = normal, bold = true },
    BufferLineDuplicate = { fg = p.fujiGray, bg = dark },
    BufferLineDuplicateSelected = { fg = p.oldWhite, bg = normal, bold = true },
    BufferLineDuplicateVisible = { fg = p.oldWhite, bg = normal },
    BufferLineSeparator = { fg = normal, bg = dark },
    BufferLineSeparatorSelected = { fg = normal, bg = normal },
    BufferLineSeparatorVisible = { fg = normal, bg = normal },
    BufferLineIndicatorSelected = { fg = normal, bg = normal },
    BufferLineIndicatorVisible = { fg = normal, bg = normal },
    BufferLineModified = { fg = p.autumnYellow, bg = dark },
    BufferLineModifiedVisible = { fg = p.autumnYellow, bg = normal },
    BufferLineModifiedSelected = { fg = p.autumnYellow, bg = normal },
    BufferLinePick = { fg = p.peachRed, bg = dark, bold = true },
    BufferLinePickVisible = { fg = p.peachRed, bg = normal, bold = true },
    BufferLinePickSelected = { fg = p.peachRed, bg = normal, bold = true },
  }
end

return M
