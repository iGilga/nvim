local M = {}

M.border = { ' ' }
M.style = 'solid'

M.zettel = {
  min_width = 50,
  border = {
    bottom_hl = 'NuiBottom',
    highlight = 'NuiBorder',
    style = M.style,
    title = ' Zettelkasten ',
    title_align = 'center',
    title_hl = 'NuiTitle',
  },
  separator = {
    char = ' ',
    text_align = 'center',
    highlight = 'NuiSeparator',
  },
  highlight = 'Normal:NuiNormal',
}

return M
