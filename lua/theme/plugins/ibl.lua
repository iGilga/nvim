local M = {}

function M.hl(colors)
  local p = colors.palette
  return {
    IblScope = { fg = p.springViolet1 },
    IblIndent = { fg = p.sumiInk6 },
    IblWhitespace = { fg = p.sumiInk6 },
  }
end

return M
