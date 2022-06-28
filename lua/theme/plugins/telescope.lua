local telescope = {
  matching = C.roninYellow,
  preview = C.dark3,
  prompt = C.selection,
  results = C.dark2,
  selection = C.selection,
  title = { bg = C.green1, fg = C.black },
}

return {
  TelescopePromptTitle = telescope.title,
  TelescopePromptCounter = { fg = C.gray },
  TelescopePromptNormal = { bg = telescope.prompt, fg = C.white },
  TelescopePromptBorder = { bg = telescope.prompt },
  TelescopeResultsTitle = telescope.title,
  TelescopeResultsNormal = { bg = telescope.results },
  TelescopeResultsBorder = { bg = telescope.results },
  TelescopePreviewTitle = telescope.title,
  TelescopePreviewNormal = { bg = telescope.preview },
  TelescopePreviewBorder = { bg = telescope.preview },
  TelescopeSelection = { link = 'CursorLine' },
  -- TelescopeMatching = { fg = telescope.matching },
  TelescopePromptPrefix = { fg = C.black },
  -- TelescopeResultsFileIcon = { bg = telescope.results, fg = colors.black },
}
