local function setup()
  local npairs = require('nvim-autopairs')
  local Rule = require('nvim-autopairs.rule')
  local cond = require('nvim-autopairs.conds')

  npairs.setup({
    disable_filetype = { 'TelescopePrompt', 'vim' },
    -- check_ts = true,
    -- ts_config = {
    --   lua = { 'string' },
    --   javascript = { 'template_string' },
    -- },
    -- map_bs = false,
    -- map_cr = false,
    fast_wrap = {
      map = '<C-w>',
      chars = { '{', '[', '(', '"', "'", '`' },
      pattern = [=[[%'%"%)%>%]%)%}%,]]=],
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      manual_position = true,
      highlight = 'Search',
      highlight_grey = 'Comment', -- enable_check_bracket_line = false,
    },
  })

  npairs.add_rules({
    npairs.add_rules({
      Rule(' ', ' ', { '-markdown' })
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ '()', '{}', '[]' }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = opts.line:sub(col - 1, col + 2)
          return vim.tbl_contains({ '(  )', '{  }', '[  ]' }, context)
        end),
      Rule('', ' )')
        :with_pair(cond.none())
        :with_move(function(opts)
          return opts.char == ')'
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(')'),
      Rule('', ' }')
        :with_pair(cond.none())
        :with_move(function(opts)
          return opts.char == '}'
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key('}'),
      Rule('', ' ]')
        :with_pair(cond.none())
        :with_move(function(opts)
          return opts.char == ']'
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(']'),
    }),
    Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' })
      :use_regex(true)
      :set_end_pair_length(2),
    Rule('=', '', { '-vim', '-sh', '-cfg', '-conf', '-html', '-systemd' })
      :with_pair(cond.not_inside_quote())
      :with_pair(function(opts)
        local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
        if last_char:match('[%w%=%s]') then
          return true
        end
        return false
      end)
      :replace_endpair(function(opts)
        local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
        local next_char = opts.line:sub(opts.col, opts.col)
        next_char = next_char == ' ' and '' or ' '
        if prev_2char:match('%w$') then
          return '<bs> =' .. next_char
        end
        if prev_2char:match('%=$') then
          return next_char
        end
        if prev_2char:match('=') then
          return '<bs><bs>=' .. next_char
        end
        return ''
      end)
      :set_end_pair_length(0)
      :with_move(cond.none())
      :with_del(cond.none()),
  })

  local ok, cmp = pcall(require, 'cmp')
  if ok then
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local handlers = require('nvim-autopairs.completion.handlers')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done({
        filetypes = {
          ['*'] = {
            ['('] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              handler = handlers['*'],
            },
          },
        },
      })
    )
  end


  local isPairs = true;
  vim.api.nvim_create_user_command('AutopairsToggle', function()
    if isPairs then
      npairs.disable()
      isPairs = false;
    elseif not isPairs then
      npairs.enable()
      isPairs = true;
    end
  end, {})
end

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = setup,
}
