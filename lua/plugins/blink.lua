return {
  'saghen/blink.cmp',
  -- event = { 'InsertEnter', 'CmdlineEnter' },
  lazy = false,
  dependencies = {
    'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    'nvim-tree/nvim-web-devicons',
    'onsails/lspkind-nvim',
  },
  version = '1.*',
  opts = {
    keymap = {
      preset = 'default',
      ['<A-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<CR>'] = { 'select_and_accept', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<Tab>'] = {
        function(cmp)
          return cmp.select_next()
        end,
        'snippet_forward',
        'fallback',
      },
      ['<S-Tab>'] = {
        function(cmp)
          return cmp.select_prev()
        end,
        'snippet_backward',
        'fallback',
      },
      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    completion = {
      documentation = { auto_show = true },
      -- accept = { auto_brackets = { enabled = true } },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      ghost_text = { enabled = true },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { 'kind_icon', 'label', gap = 1 },
            { 'source_name' },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local lspkind = require('lspkind')
                local icon = ctx.kind_icon
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = lspkind.symbolic(ctx.kind, {
                    mode = 'symbol',
                  })
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
            source_name = {
              width = { max = 10 },
              text = function(ctx)
                return ctx.source_name
              end,
            },
          },
        },
      },
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'snippets', 'buffer', 'path' },
      providers = {
        lsp = {
          -- min_keyword_length = 1,
          score_offset = 0,
        },
        snippets = {
          min_keyword_length = 1,
        },
        buffer = {
          min_keyword_length = 2,
          max_items = 5,
        },
        path = {
          min_keyword_length = 0,
        },
      },
    },
    fuzzy = {
      implementation = 'lua',
      prebuilt_binaries = {
        download = false,
      },
    },
    cmdline = {
      keymap = {
        ['<Tab>'] = {
          function(cmp)
            return cmp.select_next()
          end,
          'snippet_forward',
          'fallback',
        },
        ['<S-Tab>'] = {
          function(cmp)
            return cmp.select_prev()
          end,
          'snippet_backward',
          'fallback',
        },
      },
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == '/' or type == '?' then
          return { 'buffer' }
        end
        if type == ':' or type == '@' then
          return { 'cmdline' }
        end
        return {}
      end,
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = {},
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = {
          auto_show = true,
        },
        ghost_text = { enabled = true },
      },
    },
  },
  -- opts_extend = { 'sources.default' },
}
