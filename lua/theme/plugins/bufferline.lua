local bg, bg_selected = C.bg_dark, C.bg
return {

  BufferLineFill = { fg = C.bg, bg = bg },
  BufferLineBackground = { fg = C.oldWhite, bg = bg },
  BufferLineBufferSelected = { fg = C.fujiWhite, bg = bg_selected, bold = true },
  BufferLineDuplicate = { fg = C.fujiGray, bg = bg },
  BufferLineDuplicateSelected = { fg = C.fujiGray, bg = bg_selected, bold = true },
  BufferLineSeparator = { fg = C.bg, bg = bg },
  BufferLineSeparatorSelected = { fg = C.bg, bg = bg_selected },
  BufferLineIndicatorSelected = { fg = C.bg, bg = bg_selected },
  BufferLineModified = { fg = C.yellow, bg = bg },
  -- BufferLineModifiedVisible = { fg = C.yellow, bg = C.bg },
  BufferLineModifiedSelected = { fg = C.yellow, bg = bg_selected },
  BufferLinePick = { fg = C.peachRed, bg = bg, bold = true },
  -- BufferLinePickVisible = { fg = C.red, bg = C.bg, bold = true },
  BufferLinePickSelected = { fg = C.peachRed, bg = bg_selected, bold = true },
}
