return {
  cmd = { 'lua-language-server' },
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_fstat(path .. '/.luarc.json') or vim.loop.fs_fstat(path .. '/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      completion = { callSnippet = 'Replace' },
      diagnostics = {
        enable = true,
        globals = {
          'vim',
          'describe',
          'it',
          'before_each',
          'after_each',
          'teardown',
          'pending',
          'use',
        },
        disable = {
          'lowercase-global',
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          },
        },
      },
    })
  end,
  settings = {
    Lua = {},
  },
}
