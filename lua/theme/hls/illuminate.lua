local M = {}
function M.hl(colors)
  local p = colors.palette
  return {
    IlluminatedWordText = { fg = p.sumiInk1, bg = p.autumnGreen, bold = true },
    IlluminatedWordRead = { fg = p.sumiInk1, bg = p.autumnYellow, bold = true },
    IlluminatedWordWrite = { fg = p.sumiInk1, bg = p.autumnRed, bold = true },
  }
end

return M
