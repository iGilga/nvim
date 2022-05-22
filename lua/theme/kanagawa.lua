local u = require('utils')
local theme = require('kanagawa.colors').setup()

local customColors = {
  bg0 = '#2A2A37',
  bg1 = '#1b1b24', --darkly
  bg2 = '#181820', --darkly
  green1 = '#52674a', --darkly
  grey1 = '#22222C',
  grey2 = '#252530',
  grey3 = '#282834',
  grey4 = '#2B2B37',
  grey5 = '#2E2E3B',
  grey6 = '#31313F',
  grey7 = '#343443',
  dark1 = '#1D1D26',
  dark2 = '#1B1B23',
  dark3 = '#191920',
}

local colors = {
  white = theme.fujiWhite,
  black = theme.oldWhite,
  bg = theme.sumiInk1,
  bg_dark = theme.sumiInk0,
  bg_light = theme.sumiInk2,
  red = theme.autumnRed,
  blue = theme.dragonBlue,
  green = theme.autumnGreen,
  yellow = theme.autumnYellow,
  purple = theme.sakuraPink,
  gray = theme.sumiInk4,
  selection = theme.sumiInk3,
}

local telescope = {
  matching = theme.roninYellow,
  preview = customColors.dark3,
  prompt = colors.selection,
  results = customColors.dark2,
  selection = colors.selection,
  title = { bg = customColors.green1, fg = colors.black },
}

local notify = {
  border = { bg = customColors.dark3 },
  info = { fg = colors.green },
  warn = { fg = colors.yellow },
  error = { fg = colors.red },
  hint = { fg = colors.purple },
  body = function(color)
    return { fg = color, bg = customColors.dark3 }
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
  TelescopePromptTitle = telescope.title,
  TelescopePromptCounter = { fg = colors.gray },
  TelescopePromptNormal = { bg = telescope.prompt, fg = colors.white },
  TelescopePromptBorder = { bg = telescope.prompt },
  TelescopeResultsTitle = telescope.title,
  TelescopeResultsNormal = { bg = telescope.results },
  TelescopeResultsBorder = { bg = telescope.results },
  TelescopePreviewTitle = telescope.title,
  TelescopePreviewNormal = { bg = telescope.preview },
  TelescopePreviewBorder = { bg = telescope.preview },
  TelescopeSelection = { link = 'CursorLine' },
  -- TelescopeMatching = { fg = telescope.matching },
  TelescopePromptPrefix = { fg = colors.black },
  -- TelescopeResultsFileIcon = { bg = telescope.results, fg = colors.black },
}

local CustomCmp = {
  CmpDocumentation = { bg = customColors.dark3 },
  CmpDocumentationBorder = { bg = customColors.dark3 },
  CmpCompletion = { bg = customColors.dark2 },
  CmpCompletionBorder = { bg = customColors.dark2 },
}

local customAlpha = {
  AlphaHeader = { fg = colors.green },
  AlphaShortcuts = { fg = colors.bg, bg = colors.green },
  AlphaButton = { fg = colors.white },
  AlphaIcon = { fg = colors.green },
}

local customTodo = {
  TodoLabel = { bg = colors.bg, fg = colors.blue },
  NoteLabel = { bg = colors.bg, fg = colors.green },
  FixLabel = { bg = colors.bg, fg = colors.red },
  WarnLabel = { bg = colors.bg, fg = colors.yellow },
}

local customNui = {
  NuiNormal = { bg = customColors.dark3, fg = colors.white },
  NuiBorder = { bg = customColors.dark3, fg = customColors.dark3 },
  NuiTitle = { bg = customColors.green1, fg = colors.black },
  NuiPrompt = { fg = colors.black },
  NuiBottom = { fg = colors.gray },
  NuiSeparator = { fg = colors.gray },
}

local customNnn = {
  NnnNormal = { link = 'NormalFloat' },
  -- NnnNormalNC = { link = 'NormalFloat' },
  NnnBorder = { link = 'FloatBorder' },
}

local custom = {
  NormalFloat = { fg = colors.white, bg = customColors.dark3 },
  FloatBorder = { fg = colors.gray, bg = customColors.dark3 },
}

local overrides = u.merge(custom, notifyGroup, TelescopeGroup, CustomCmp, customAlpha, customTodo, customNui, customNnn)

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
