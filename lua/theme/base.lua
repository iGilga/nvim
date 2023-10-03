local M = {}

function M.hl(colors)
  local p = colors.pallete
  return {
    NormalFloat = { fg = p.fujiWhite, bg = p.dark3 },
    FloatBorder = { fg = p.sumiInk4, bg = p.dark3 },
    CBorder = { fg = p.autumnGreen, bg = p.autumnGreen },
    -- TSDefinitionUsage = { fg = C.bg, bg = C.green },
    -- TSDefinition = { fg = C.bg, bg = C.yellow },
  }
end

return M
