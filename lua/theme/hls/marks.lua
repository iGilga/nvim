local M = {}
function M.hl(colors)
  local p = colors.palette
  return {
    MarkSignHL = { fg = p.fujiGray },
  }
end

return M
