local M = {}
function M.hl(colors)
  local p = colors.palette
  return {
    NuiNormal = { fg = p.fujiWhite, bg = p.dark3 },
    NuiBorder = { fg = p.dark3 },
    NuiTitle = { bg = p.green1, fg = p.oldWhite },
    NuiPrompt = { fg = p.green1 },
    NuiBottom = { fg = p.fujiGray },
    NuiGrayText = { fg = p.fujiGray },
    NuiSeparator = { fg = p.fujiGray },
    NuiText = { fg = p.fujiWhite }
  }
end

return M
