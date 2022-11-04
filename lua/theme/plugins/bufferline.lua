local dark, normal = C.bg_dark, C.bg
return {

  BufferLineFill = { fg = dark, bg = dark },
  BufferLineBackground = { fg = C.fujiGray, bg = dark },
  BufferLineBufferVisible = { fg = C.oldWhite, bg = normal },
  BufferLineBufferSelected = { fg = C.oldWhite, bg = normal, bold = true },
  BufferLineDuplicate = { fg = C.fujiGray, bg = dark },
  BufferLineDuplicateSelected = { fg = C.fujiGray, bg = normal, bold = true },
  BufferLineDuplicateSelectedVisible = { fg = C.fujiGray, bg = normal, bold = true },
  BufferLineSeparator = { fg = C.bg, bg = dark },
  BufferLineSeparatorSelected = { fg = C.bg, bg = normal },
  BufferLineSeparatorVisible = { fg = C.bg, bg = normal },
  BufferLineIndicatorSelected = { fg = C.bg, bg = normal },
  BufferLineIndicatorVisible = { fg = C.bg, bg = normal },
  BufferLineModified = { fg = C.yellow, bg = dark },
  BufferLineModifiedVisible = { fg = C.yellow, bg = normal },
  BufferLineModifiedSelected = { fg = C.yellow, bg = normal },
  BufferLinePick = { fg = C.peachRed, bg = dark, bold = true },
  BufferLinePickVisible = { fg = C.red, bg = C.normal, bold = true },
  BufferLinePickSelected = { fg = C.peachRed, bg = normal, bold = true },
}
