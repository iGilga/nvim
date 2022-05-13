local u = require('utils')
local theme = require('kanagawa.colors').setup()

local customColors = {
  bg1 = '#1b1b24', --darkly
  bg2 = '#181820', --darkly
  green1 = '#52674a', --darkly
}

local colors = {
  white = theme.fujiWhite,
  black = theme.oldWhite,
  bg = theme.sumiInk1,
  bg_dark = theme.sumiInk0,
  bg_highlight = theme.sumiInk2,
  red = theme.autumnRed,
  blue = theme.dragonBlue,
  green = theme.autumnGreen,
  yellow = theme.autumnYellow,
  purple = theme.sakuraPink,
  gray = theme.sumiInk4,
}

local telescope = {
  matching = theme.roninYellow,
  preview = customColors.bg2,
  prompt = customColors.green1,
  results = customColors.bg1,
  selection = customColors.green1,
  title = { bg = customColors.green1, fg = colors.black },
}

local notify = {
  border = { bg = colors.bg_dark },
  info = { fg = colors.green },
  warn = { fg = colors.yellow },
  error = { fg = colors.red },
  hint = { fg = colors.purple },
  body = function(color)
    return { fg = color, bg = colors.bg_dark }
  end,
}

local notifyGroup = {
  NotifyINFOBorder = notify.border,
  NotifyINFOIcon = notify.info,
  NotifyINFOTitle = notify.info,
  NotifyINFOBody = notify.body(colors.green),
  NotifyWARNBorder = notify.border,
  NotifyWARNIcon = notify.warn,
  NotifyWARNTitle = notify.warn,
  NotifyWARNBody = notify.body(colors.yellow),
  NotifyERRORBorder = notify.border,
  NotifyERRORIcon = notify.error,
  NotifyERRORTitle = notify.error,
  NotifyERRORBody = notify.body(colors.red),
  NotifyTRACEBorder = notify.border,
  NotifyTRACEIcon = notify.hint,
  NotifyTRACETitle = notify.hint,
  NotifyTRACEBody = notify.body(colors.purple),
}

local TelescopeGroup = {
  TelescopePromptTitle = { bg = telescope.prompt, fg = telescope.prompt },
  TelescopePromptCounter = { fg = colors.black },
  TelescopePromptNormal = { bg = telescope.prompt, fg = colors.white },
  TelescopePromptBorder = { bg = telescope.prompt },
  TelescopeResultsTitle = telescope.title,
  TelescopeResultsNormal = { bg = telescope.results },
  TelescopeResultsBorder = { bg = telescope.results },
  TelescopePreviewTitle = telescope.title,
  TelescopePreviewNormal = { bg = telescope.preview },
  TelescopePreviewBorder = { bg = telescope.preview },
  TelescopeSelection = { bg = telescope.selection },
  TelescopeMatching = { fg = telescope.matching },
  TelescopePromptPrefix = { fg = colors.black },
}

local alphaGroup = {
  AlphaHeader = { fg = colors.green },
  AlphaShortcuts = { fg = colors.bg, bg = colors.green },
  AlphaButton = { fg = colors.white },
  AlphaIcon = { fg = colors.green },
}

local todoGroup = {
  TodoLabel = { bg = colors.bg, fg = colors.blue },
  NoteLabel = { bg = colors.bg, fg = colors.green },
  FixLabel = { bg = colors.bg, fg = colors.red },
  WarnLabel = { bg = colors.bg, fg = colors.yellow },
}

local overrides = u.merge(notifyGroup, TelescopeGroup, alphaGroup, todoGroup)

local M = {}

function M.setup(name)
  local setup = {
    globalStatus = true,
    overrides = overrides,
  }
  local kanagawa = require('kanagawa')
  kanagawa.setup(setup)
  u.load(name)
end

M.colors = colors

M.customColors = customColors

return M
