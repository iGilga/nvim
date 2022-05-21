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
        autostart = true,
      },
    },
    graphql = {},
    html = {},
    jsonls = {},
    sumneko_lua = {},
    tsserver = {
      formatting = false,
    },
    yamlls = {},
  },
}

M.rename = {
  min_width = 40,
  border = {
    highlight = 'NuiBorder',
    style = 'solid',
    title = ' Rename ',
    title_align = 'center',
    title_hl = 'NuiTitle',
  },
  prompt = '> ',
  prompt_hl = 'NuiPrompt',
  highlight = "Normal:NuiNormal",
}

M.codeAction = {
  min_width = 40,
  border = {
    bottom_hl = 'NuiBottom',
    highlight = 'NuiBorder',
    style = 'solid',
    title = ' Code Actions ',
    title_align = 'center',
    title_hl = 'NuiTitle',
  },
  separator = {
    char = ' ',
    text_align = 'center',
    highlight = 'NuiSeparator'
  },
  highlight = "Normal:NuiNormal",
}

M.plugins = {
  treesitter = {
    ensure_installed = {
      'bash',
      'css',
      'dockerfile',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'markdown',
      'scss',
      'toml',
      'yaml',
    },
  },
}

M.disablePlugins = {
  'better-escape.nvim',
  'nvim-cursorline',
}

return M
