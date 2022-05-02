local c = vim.cmd
local ok, kanagawa = pcall(require, 'theme.color.kanagawa')

if not ok then
  return false
end

local colors = kanagawa.colors

local bg = function(group, color)
  c('highlight  ' .. group .. ' guibg=' .. color)
end

local fg = function(group, color)
  c('hi ' .. group .. ' guifg=' .. color)
end

local bgfg = function(group, bgColor, fgColor)
  c('highlight ' .. group .. ' guibg=' .. bgColor .. ' guifg=' .. fgColor)
end

fg('NotifyINFOBorder', colors.green)
fg('NotifyINFOIcon', colors.green)
fg('NotifyINFOTitle', colors.green)
fg('NotifyINFOBody', colors.white)

fg('NotifyWARNBorder', colors.yellow)
fg('NotifyWARNIcon', colors.yellow)
fg('NotifyWARNTitle', colors.yellow)
fg('NotifyWARNBody', colors.white)

fg('NotifyERRORBorder', colors.red)
fg('NotifyERRORIcon', colors.red)
fg('NotifyERRORTitle', colors.red)
fg('NotifyERRORTBody', colors.white)

fg('NotifyTRACEBorder', colors.purple)
fg('NotifyTRACEIcon', colors.purple)
fg('NotifyTRACETitle', colors.purple)
fg('NotifyTRACETBody', colors.white)
