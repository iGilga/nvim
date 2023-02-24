---@diagnostic disable: undefined-global
return {
  s(
    { trig = 'pcall', name = 'protected call' },
    fmt(
      [[
      local ok, {} = pcall(require, '{}')
      if not ok then return end
      ]],
      { i(1, 'name'), i(2, 'module') }
    )
  ),
  s({ trig = 'req', name = 'local require' }, fmt("local {} = require('{}')", { i(1, 'name'), i(2, 'module') })),
  s(
    { trig = 'lf', name = 'local function' },
    fmt(
      [[
      local function {}({})
        {}
      end
      ]],
      { i(1, 'name'), i(2, 'args'), i(0) }
    )
  ),
}
