P = function(...)
  vim.print(...)
end

_G.valhalla = {}

function valhalla.merge(...)
  return vim.tbl_deep_extend('force', ...)
end
