local M = {}
function M.hl(colors)
  local p = colors.palette
  return {
    NuiNormal = { bg = p.dark3, fg = p.fujiWhite },
    NuiBorder = { bg = p.dark3, fg = p.dark3 },
    NuiTitle = { bg = p.green1, fg = p.oldWhite },
    NuiPrompt = { fg = p.green1 },
    NuiBottom = { fg = p.fujiGray },
    NuiSeparator = { fg = p.fujiGray },
    NuiText = { fg = p.fujiWhite }
  }
end

return M
