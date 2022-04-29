local c = vim.cmd
local ok, kanagawa = pcall(require, 'kanagawa.colors')

if not ok then
  return false
end

local colors = kanagawa.setup()

local bg = function(group, color)
  c('highlight  ' .. group .. ' guibg=' .. color)
end

local fg = function(group, color)
  c('highlight ' .. group .. ' guifg=' .. color)
end

local bgfg = function (group, bgColor, fgColor)
  c('highlight ' .. group .. ' guibg=' .. bgColor .. ' guifg=' .. fgColor)
end

fg('NotifyINFOBorder', colors.autumnGreen)
fg('NotifyINFOIcon', colors.autumnGreen)
fg('NotifyINFOTitle', colors.autumnGreen)
fg('NotifyINFOBody', colors.fujiWhite)

fg('NotifyWARNBorder', colors.autumnYellow)
fg('NotifyWARNIcon', colors.autumnYellow)
fg('NotifyWARNTitle', colors.autumnYellow)

fg('NotifyERRORBorder', colors.autumnRed)
fg('NotifyERRORIcon', colors.autumnRed)
fg('NotifyERRORTitle', colors.autumnRed)

fg('NotifyTRACEBorder', colors.surimiOrange)
fg('NotifyTRACEIcon', colors.surimiOrange)
fg('NotifyTRACETitle', colors.surimiOrange)
