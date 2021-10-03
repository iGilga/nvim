local use = require('packer').use
use 'EdenEast/nightfox.nvim'
local nightfox = require('nightfox')

local foxStyle = 'nightfox'

nightfox.setup({
  fox = foxStyle,
  styles = {
    comments = 'italic',
    keyword = 'bold',
    finctions = 'italic,bold'
  }
})

nightfox.load()

require('lualine').setup {
  options = {
    theme = foxStyle
  }
}
