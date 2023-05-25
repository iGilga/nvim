local setup = {
  filetypes = {
    'html',
    'css',
    'javsscript',
    'javascriptreact',
    'lua',
    '!packer',
  },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue or blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    AARRGGBB = false, -- 0xAARRGGBB hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    -- css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    -- css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    mode = 'background', -- Set the display mode
    tailwind = true,
    virtualtext = '■',
  },
}

return {
  'NvChad/nvim-colorizer.lua',
  -- event = 'BufReadPre',
  keys = {
    { '<a-x>', ':ColorizerToggle<cr>', desc = 'Toogle colorizer', { silent = true } },
  },
  opts = setup,
}
