local M = {}
function M.hl(colors)
  local p = colors.palette
  local telescope = {
    matching = p.roninYellow,
    preview = p.dark3,
    prompt = p.sumiInk3,
    results = p.dark2,
    selection = p.sumiInk3,
    title = { bg = p.green1, fg = p.oldWhite },
  }

  return {
    TelescopePromptTitle = telescope.title,
    TelescopePromptCounter = { fg = p.fujiGray },
    TelescopePromptNormal = { bg = telescope.prompt, fg = p.fujiWhite },
    TelescopePromptBorder = { bg = telescope.prompt },
    TelescopeResultsTitle = telescope.title,
    TelescopeResultsNormal = { bg = telescope.results },
    TelescopeResultsBorder = { bg = telescope.results },
    TelescopePreviewTitle = telescope.title,
    TelescopePreviewNormal = { bg = telescope.preview },
    TelescopePreviewBorder = { bg = telescope.preview },
    TelescopeSelection = { link = 'CursorLine' },
    TelescopeMatching = { fg = telescope.matching },
    TelescopePromptPrefix = { fg = p.oldWhite },
    -- TelescopeResultsFileIcon = { bg = telescope.results, fg = colors.black },
  }
end

return M
