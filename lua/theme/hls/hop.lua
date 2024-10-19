local M = {}
function M.hl(colors)
  local p = colors.palette
  return {
    HopNextKey = { fg = p.roninYellow, bold = true },
    HopNextKey1 = { fg = p.waveAqua1, bold = true },
    HopNextKey2 = { fg = p.waveAqua2 },
    HopUnmatched = { fg = p.fujiGray },
    HopCursor = { link = 'Cursor' },
    -- HopPreview = { fg = C.surimiOrange, bold = true },
  }
end

return M
