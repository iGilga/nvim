_G.KeymapStore = _G.KeymapStore or {}
local buildmap = function(mode, defaults, args)
  local lhs = args[1]
  local rhs = args[2]
  local opts = defaults
  if args[3] then
    opts = vim.tbl_extend("force", defaults, args[3])
  end
  local buffer = opts.buffer or nil
  opts.buffer = nil

  if type(rhs) == "function" then
    local fn_id = "nap" .. (vim.tbl_count(KeymapStore) + 1)
    if buffer then
      fn_id = ("%s_buf%s"):format(fn_id, buffer)
    end
    KeymapStore[fn_id] = rhs
    assert(opts.noremap, "If `rhs` is a function, `opts.noremap` must be true")
    rhs =
      not opts.expr and ("<cmd>lua KeymapStore['%s']()<cr>"):format(fn_id) or ("v:lua.KeymapStore.%s()"):format(fn_id)
  end
  if not buffer then
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  else
    vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
  end
end

local keymap = {}

function keymap.map(args)
  return buildmap("", {noremap = false}, args)
end

function keymap.noremap(args)
  return buildmap("", {noremap = true}, args)
end

function keymap.nmap(args)
  return buildmap("n", {noremap = false}, args)
end

function keymap.nnoremap(args)
  return buildmap("n", {noremap = true}, args)
end

function keymap.imap(args)
  return buildmap("i", {noremap = false}, args)
end

function keymap.inoremap(args)
  return buildmap("i", {noremap = true}, args)
end

function keymap.vmap(args)
  return buildmap("v", {noremap = false}, args)
end

function keymap.vnoremap(args)
  return buildmap("v", {noremap = true}, args)
end

function keymap.xmap(args)
  return buildmap("x", {noremap = false}, args)
end

function keymap.xnoremap(args)
  return buildmap("x", {noremap = true}, args)
end

function keymap.smap(args)
  return buildmap("s", {noremap = false}, args)
end

function keymap.snoremap(args)
  return buildmap("s", {noremap = true}, args)
end

function keymap.omap(args)
  return buildmap("o", {noremap = false}, args)
end

function keymap.onoremap(args)
  return buildmap("o", {noremap = true}, args)
end

function keymap.lmap(args)
  return buildmap("l", {noremap = false}, args)
end

function keymap.lnoremap(args)
  return buildmap("l", {noremap = true}, args)
end

function keymap.cmap(args)
  return buildmap("c", {noremap = false}, args)
end

function keymap.cnoremap(args)
  return buildmap("c", {noremap = true}, args)
end

function keymap.tmap(args)
  return buildmap("t", {noremap = false}, args)
end

function keymap.tnoremap(args)
  return buildmap("t", {noremap = true}, args)
end

function keymap.nmaps(args)
  return buildmap("n", {noremap = false, silent = true}, args)
end

function keymap.nnoremaps(args)
  return buildmap("n", {noremap = true, silent = true}, args)
end

function keymap.t(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

return keymap
