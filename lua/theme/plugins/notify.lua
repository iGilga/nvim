local colorLevels = {
  ['INFO'] = C.green,
  ['WARN'] = C.yellow,
  ['ERROR'] = C.red,
  ['TRACE'] = C.purple,
}
local notifyHiglighs = {}
for level, color in pairs(colorLevels) do
  notifyHiglighs['Notify' .. level .. 'Border'] = { fg = color, bg = C.dark3 }
  notifyHiglighs['Notify' .. level .. 'Icon'] = { bg = color }
  notifyHiglighs['Notify' .. level .. 'Title'] = { fg = color }
  notifyHiglighs['Notify' .. level .. 'Body'] = { fg = C.black, bg = C.dark3 }
  notifyHiglighs['Notify' .. level .. 'Sign'] = { bg = color }
end

return notifyHiglighs
