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
  local v = vim.version()
  local lazy_ok, lazy = pcall(require, 'lazy')
  if lazy_ok then
    return { string.format(' %d   v%d.%d.%d', lazy.stats().count, v.major, v.minor, v.patch) }
  else
    return { string.format(' v%d.%d.%d', v.major, v.minor, v.patch) }
  end
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
    width = 40,
    align_shortcut = 'right',
    hl_shortcut = 'AlphaShortcuts',
    hl = {
      { 'AlphaIcon', 1, 3 },
      { 'AlphaButton', 4, 20 },
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
    button('Space s f', '  Open session', '<cmd>SessionManager! load_session<cr>'),
    button('Space f f', '  Find File', ':Telescope find_files<CR>'),
    button('Space f o', '  Recent File', ':Telescope oldfiles<CR>'),
    button('Space l l', '  Open repo', ':LazyGit<cr>'),
    button('Ctrl  t  ', '  File browsr', '<cmd>:NnnPicker<cr>'),
    button('F4', '  Load current session', '<cmd>:SessionManager load_current_dir_session<cr>'),
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

alpha.setup(opts)
