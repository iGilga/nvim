---@diagnostic disable: undefined-global
return {
  s({
    trig = 'shebang',
    name = 'preferred shebang',
  }, {
    t('#!/bin/sh'),
    i(0),
  }),
  s({
    trig = 'var',
    name = 'variable indicator',
  }, fmt('"${}"', i(1, 'var'))),
  s(
    'if',
    fmt(
      [[
      if [ {} ]; then
            {}
      fi
      ]],
      ins_generate()
    )
  ),
}
