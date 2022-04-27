local M = {}

M.theme = 'kanagawa'

M.border = 'single'

M.leader = ' '

M.lsp = {
  servers = {
    bashls = {},
    cssls = {},
    dockerls = {},
    eslint = {
      opts = {
        autostart = false,
      },
    },
    graphql = {},
    html = {},
    jsonls = {},
    remark_ls = {},
    sumneko_lua = {},
    tsserver = {},
    yamlls = {},
  },
}

M.formatter = {
  eslint = false,
  sumneko_lua = false,
  tsserver = false,
}

M.rename = {
  border = {
    highlight = 'FloatBorder',
    style = M.border,
    title = '[Rename]',
    title_align = 'center',
    title_hl = 'FloatBorder',
  },
  prompt = '> ',
  prompt_hl = 'Comment',
}

M.codeAction = {
  min_width = 40,
  border = {
    bottom_hl = 'FloatBorder',
    highlight = 'FloatBorder',
    style = M.border,
    title = '[Code Actions]',
    title_align = 'center',
    title_hl = 'FloatBorder',
  },
  separator = {
    char = ' ',
    text_align = 'center',
  },
}

M.plugins = {
  treesitter = {
    ensure_installed = {
      'bash',
      'css',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'markdown',
      'scss',
      'yaml',
    },
  },
}

M.disablePlugins = {
  'trouble.nvim',
  'better-escape.nvim',
  'nvim-cursorline',
}

return M
