local M = {}

function M.hl(colors)
  local p = colors.palette
  return {
    TodoLabel = { bg = p.sumiInk1, fg = p.dragonBlue },
    NoteLabel = { bg = p.sumiInk1, fg = p.autumnGreen },
    FixLabel = { bg = p.sumiInk1, fg = p.autumnRed },
    WarnLabel = { bg = p.sumiInk1, fg = p.autumnYellow },
  }
end

return M
