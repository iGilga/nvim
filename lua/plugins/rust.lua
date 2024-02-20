local default = require('lsp.servers.default')
local init = function()
  vim.g.rustaceanvim = {
    server = {
      on_attach = default.on_attach,

    }
  }
end
return {
  'mrcjkb/rustaceanvim',
  version = '^4', -- Recommended
  ft = { 'rust' },
  init = init
}
