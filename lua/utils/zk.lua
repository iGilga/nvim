local Menu = require('nui.menu')
local ntext = require('nui.text')
local config = require('config.user').zettel

M = {}

local cmd_list = {
  { title = 'Open notes',           cmd = ':ZkNotes' },
  { title = 'Open notes with tags', cmd = ':ZkTags' },
  { title = 'Create note',          cmd = ':ZkNew' },
  { title = 'Index note',           cmd = ':ZkIndex' },
}

-- local cmd_list = {
--   {
--     title = 'Open notes',
--     cmd = function()
--       require('zk').pick_notes()
--     end,
--   },
--   {
--     title = 'Open notes with tags',
--     cmd = function()
--       require('zk').pick_tags()
--     end,
--   },
-- }
local popup_opts = {
  position = '50%',
  size = {
    width = 50,
    -- height = 10,
  },
  highlight = config.highlight or 'Normal:Normal',
  border = {
    highlight = config.border.highlight,
    style = config.border.style,
    text = {
      top = ntext(config.border.title, config.border.title_hl),
    },
    padding = { 0, 1, 0, 1 },
  },
}

local openZkMenu = function()
  local items = {}
  for _, cmd in pairs(cmd_list) do
    local item = Menu.item(cmd.title)
    item.ctx = cmd
    table.insert(items, item)
  end
  local menu = Menu(popup_opts, {
    lines = items,
    max_width = 20,
    keymap = {
      focus_next = { 'j', '<Down>', '<Tab>' },
      focus_prev = { 'k', '<up>', '<S-tab>' },
      close = { 'h', '<esc>' },
      submit = { '<cr>', '<space>' },
    },
    on_close = function() end,
    on_submit = function(item)
      vim.cmd(item.ctx.cmd)
    end,
  })

  menu:mount()
end

M.zkcmd = openZkMenu

return M
