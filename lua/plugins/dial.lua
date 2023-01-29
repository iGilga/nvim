local function keys()
  local mdial = require('dial.map')
  return {
    { '<C-a>', mdial.inc_normal(), { noremap = true, desc = 'dial increment' } },
    { '<C-x>', mdial.dec_normal(), { noremap = true, desc = 'dial decrement' } },
  }
end

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
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>a', mdial.inc_normal('javascript'), { noremap = true, desc = 'dial for js' })
    end,
  })
end

return {
  'monaqa/dial.nvim',
  keys = keys,
  config = setup,
}
