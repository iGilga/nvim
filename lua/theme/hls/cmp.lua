local M = {}
function M.hl(colors)
  local p = colors.palette
  return {
    CmpDocumentation = { bg = p.dark3 },
    CmpDocumentationBorder = { bg = p.dark3 },
    CmpCompletion = { bg = p.dark2 },
    CmpCompletionBorder = { bg = p.dark2 },
  }
end

return M
