local keys = {
  {
    '<C-a>',
    function()
      require('dial.map').inc_normal()
    end,
    desc = '[dial]Increment',
  },
  {
    '<C-x>',
    function()
      require('dial.map').dec_normal()
    end,
    desc = '[dial]Decrement',
  },
}

local function setup()
  local augend = require('dial.augend')
  local cdial = require('dial.config')
  local mdial = require('dial.map')

  cdial.augends:register_group({
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias['%Y/%m/%d'],
      augend.constant.alias.bool,
    },
    javascript = {
      augend.constant.new({
        elements = { '&&', '||' },
        word = false,
        cyclic = true,
      }),
      -- augend.constant.alias.bool,
      augend.constant.new({ elements = { 'let', 'const' } }),
    },
  })

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { '*.js', '*.jsx' },
    callback = function()
      vim.api.nvim_buf_set_keymap(
        0,
        'n',
        '<C-s>',
        mdial.inc_normal('javascript'),
        { noremap = true, desc = '[dial]Change condition for js and jsx' }
      )
    end,
  })
end

return {
  'monaqa/dial.nvim',
  keys = keys,
  config = setup,
}
