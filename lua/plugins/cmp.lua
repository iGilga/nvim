local cmp = require('cmp')
local luasnip = require('luasnip')
local config = require('config')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local get_formatting = function()
  local ok, _ = pcall(require, 'lspkind')
  if not ok then
    return {}
  end

  return {
    format = require('lspkind').cmp_format({
      with_text = true,
      menu = {
        buffer = '[buffer]',
        nvim_lsp = '[lsp]',
        nvim_lua = '[lua]',
        path = '[path]',
        luasnip = '[snip]',
      },
    }),
  }
end

local setup = {
  snippet = {
    expand = function(args)
      return luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<S-Enter>'] = cmp.mapping.complete(),
    ["<A-Space>"] = cmp.mapping.complete(),
    ['<C-;>'] = cmp.mapping.close(),
    ['<C-a>'] = cmp.mapping.abort(),
    -- disabled for autopairs mapping
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
        -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
        -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  experimental = {
    ghost_text = true,
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp', max_item_count = 5 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'nvim_lua', max_item_count = 5 },
    { name = 'path' },
  },
  formatting = get_formatting(),
  window = {
    documentation = {
      border = config.style,
      winhighlight = 'Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder,Search:None',
    },
    completion = {
      winhighlight = 'Normal:CmpCompletion,FloatBorder:CmpCompletionBorder,Search:None',
    },
  },
}

vim.cmd([[
  autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
]])

cmp.setup(setup)

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline', max_item_count = 15 },
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})
