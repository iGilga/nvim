P = function(...)
  vim.print(...)
end

FP = function(s, target, flag)
  local path = '/home/stag/logs/' .. s .. '.json'
  local f = flag or false
  if flag then
    f = io.open(path, 'a+')
  else
    f = io.open(path, 'w')
  end
  if f then
    local log = vim.json.encode(target)
    f:write(log)
    f:close()
  end
end

_G.valhalla = {}

function valhalla.merge(...)
  return vim.tbl_deep_extend('force', ...)
end
