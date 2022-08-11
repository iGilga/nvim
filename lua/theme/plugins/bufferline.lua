local dark, normal = C.bg_dark, C.bg
return {

  BufferLineFill = { fg = dark, bg = dark },
  BufferLineBackground = { fg = C.oldWhite, bg = dark },
  BufferLineBufferSelected = { fg = C.oldWhite, bg = normal, bold = true },
  BufferLineDuplicate = { fg = C.fujiGray, bg = dark },
  BufferLineDuplicateSelected = { fg = C.fujiGray, bg = normal, bold = true },
  BufferLineSeparator = { fg = C.bg, bg = dark },
  BufferLineSeparatorSelected = { fg = C.bg, bg = normal },
  BufferLineIndicatorSelected = { fg = C.bg, bg = normal },
  BufferLineModified = { fg = C.yellow, bg = dark },
  -- BufferLineModifiedVisible = { fg = C.yellow, bg = C.bg },
  BufferLineModifiedSelected = { fg = C.yellow, bg = normal },
  BufferLinePick = { fg = C.peachRed, bg = dark, bold = true },
  -- BufferLinePickVisible = { fg = C.red, bg = C.bg, bold = true },
  BufferLinePickSelected = { fg = C.peachRed, bg = normal, bold = true },
}
