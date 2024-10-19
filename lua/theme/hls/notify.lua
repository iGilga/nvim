local M = {}

function M.hl(colors)
  local p = colors.palette

  local colorLevels = {
    ['INFO'] = p.autumnGreen,
    ['WARN'] = p.autumnYellow,
    ['ERROR'] = p.autumnRed,
    ['TRACE'] = p.sakuraPink,
  }
  local notifyHiglighs = {}
  for level, color in pairs(colorLevels) do
    notifyHiglighs['Notify' .. level .. 'Border'] = { fg = color, bg = p.dark3 }
    notifyHiglighs['Notify' .. level .. 'Icon'] = { bg = color }
    notifyHiglighs['Notify' .. level .. 'Title'] = { fg = color }
    notifyHiglighs['Notify' .. level .. 'Body'] = { fg = p.oldWhite, bg = p.dark3 }
    notifyHiglighs['Notify' .. level .. 'Sign'] = { bg = color }
  end
  return notifyHiglighs
end

return M
