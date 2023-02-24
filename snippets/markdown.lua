---@diagnostic disable: undefined-global
return {
  s(
    {
      trig = 'link',
      name = 'Create markdown link [txt](url)',
    },
    fmt(
      '[{}]({})',
      { i(1, 'description'), f(function(_, snip)
        return snip.env.TM_SELECTED_TEXT[1] or {}
      end, {}) }
    )
  ),
  s(
    {
      trig = 'lang',
      name = 'code block markdown language',
    },
    fmt(
      [[
      ```{}
      {}
      ```
      ]],
      { i(1, 'language'), i(2, 'body') }
    )
  ),
}
