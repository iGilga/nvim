local npairs = require('nvim-autopairs')
npairs.setup({
  disable_filetype = { 'TelescopePrompt', 'vim' },
  -- map_bs = false,
  -- map_cr = false,
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
