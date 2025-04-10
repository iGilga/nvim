return function(colors)
  local hls = {}
  for plugin, enabled in pairs({
    base = true,
    alpha = true,
    hop = true,
    ibl = true,
    illuminate = true,
    marks = true,
    notify = true,
    nui = true,
    telescope = true,
    todo = true,
  }) do
    if enabled then
      local m = require('theme.hls.' .. plugin)
      hls = vim.tbl_deep_extend('force', hls, m.hl(colors))
    end
  end
  return hls
end
