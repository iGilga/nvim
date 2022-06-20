local present, alpha = pcall(require, 'alpha')
if not present then
  return
end

local banner = require('utils.banner')

local header = {
  type = 'text',
  val = banner['valhalla'],
  opts = {
    position = 'center',
    hl = 'AlphaHeader',
  },
}

local datetime = os.date(' %A, %d %B %Y')

local calendar = {
  type = 'text',
  val = { string.format('%s', datetime) },
  opts = {
    position = 'center',
  },
}

local footerText = function()
---@diagnostic disable-next-line: undefined-global
  local plugins = #vim.tbl_keys(packer_plugins)
  local v = vim.version()
  return { string.format(' %d   v%d.%d.%d', plugins, v.major, v.minor, v.patch) }
end

local footer = {
  type = 'text',
  val = footerText(),
  opts = {
    position = 'center',
    hl = 'AlphaHeader',
  },
}

local function button(sc, txt, keybind)
  local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

  local opts = {
    position = 'center',
    text = txt,
    shortcut = ' ' .. sc .. ' ',
    cursor = 5,
    width = 34,
    align_shortcut = 'right',
    hl_shortcut = 'AlphaShortcuts',
    hl = {
      { 'AlphaIcon', 1, 3 },
      { 'AlphaButton', 4, 20 }
    },
  }
  if keybind then
    opts.keymap = { 'n', sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = 'button',
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, 'normal', false)
    end,
    opts = opts,
  }
end

local buttons = {
  type = 'group',
  val = {
    button('Space s l', '  Open session', ':Telescope session-lens search_session<cr>'),
    button('Space f f', '  Find File', ':Telescope find_files<CR>'),
    button('Space f o', '  Recent File', ':Telescope oldfiles<CR>'),
    button('Space l l', '  Open repo', ':LazyGit<cr>'),
    button('Ctrl  h  ', '  File browsr', '<cmd>:NnnPicker<cr>'),
  },
  opts = {
    position = 'center',
    spacing = 1,
  },
}

local section = {
  header = header,
  calendar = calendar,
  buttons = buttons,
  footer = footer,
}
local area = function(offset)
  return { type = 'padding', val = offset }
end

local paddingSpace = 2
local heightContext = #section.header.val + #section.calendar.val + #section.buttons.val + paddingSpace
local headPadding = math.max(0, math.ceil((vim.fn.winheight('$') - heightContext) * 0.10))

local opts = {
  layout = {
    area(headPadding),
    section.header,
    area(paddingSpace),
    section.calendar,
    area(paddingSpace),
    section.buttons,
    area(paddingSpace),
    section.footer,
  },
  opts = {
    -- margin = 50,
  },
}

vim.api.nvim_create_augroup('alpha_tabline', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'alpha_tabline',
  pattern = 'alpha',
  callback = function ()
    vim.opt.laststatus = 0
    vim.opt.showtabline = 0
  end
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'alpha_tabline',
  pattern = 'alpha',
  callback = function()
    vim.api.nvim_create_autocmd('BufUnload', {
      group = 'alpha_tabline',
      buffer = 0,
      callback = function ()
        vim.opt.laststatus = 3
        vim.opt.showtabline = 2
      end,
    })
  end,
})

alpha.setup(opts)


