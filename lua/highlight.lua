local ok, kanagawa = pcall(require, 'theme.color.kanagawa')

if not ok then
  return false
end

local load = function(highlights)
  for group, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

load(kanagawa.groups)
