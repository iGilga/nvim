local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

local section = {}
local action = {}

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl = 'AlphaButton'
  b.opts.hl_shortcut = 'AlphaButtonShortcut'
  return b
end

local function footer()
  local plugins = #vim.tbl_keys(packer_plugins)
  local v = vim.version()
  local datetime = os.date(' %d-%m-%Y   %H:%M:%S')
  local platform = vim.fn.has == 'win32' == 1 and '' or ''
  return string.format(' %d   v%d.%d.%d %s  %s', plugins, v.major, v.minor, v.patch, platform, datetime)
end

dashboard.section.header.val = {
  '                                                     ',
  '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                                     ',
}

dashboard.section.buttons.val = {
  -- dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
  button('Space s l', '  Open session', ':Telescope session-lens search_session<cr>'),
  button('Space f f', '  Find file', ':Telescope find_files<cr>'),
  -- button('Space t o', '  Recently opened files'),
  button('Ctrl t', '  File browsr', '<cmd>:NnnPicker<cr>'),
  -- button('Space f l l', '  Find repo', "<cmd>lua require('telescope').extensions.lazygit.lazygit()<cr>"),
  button('Space l l', '  Open repo', ':LazyGit<cr>'),
  button('Space c n', '  New file', ':ene <BAR> startinsert <cr>'),
  button('Space q', '  Quit', '<cmd>qa<cr>'),
}
dashboard.section.footer.val = footer()

-- dashboard.config.opts.noautocmd = true

vim.api.nvim_create_augroup('alpha_tabline', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'alpha_tabline',
  pattern = 'alpha',
  command = 'set showtabline=0 laststatus=0 noruler',
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'alpha_tabline',
  pattern = 'alpha',
  callback = function()
    vim.api.nvim_create_autocmd('BufUnload', {
      group = 'alpha_tabline',
      buffer = 0,
      command = 'set showtabline=2 ruler laststatus=3',
    })
  end,
})

-- Disable folding on alpha buffer
vim.api.nvim_create_autocmd('FileType', {
  group = 'alpha_tabline',
  pattern = 'alpha',
  command = 'setlocal nofoldenable',
})

alpha.setup(dashboard.config)

-- dashboard.section.buttons.val = {
--   dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
--   dashboard.button('f', '  > Find file', ':cd $HOME/project | Telescope find_files<CR>'),
--   dashboard.button('r', '  > Recent', ':Telescope oldfiles<CR>'),
--   dashboard.button('s', '  > Settings', ':e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>'),
--   dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
-- }
