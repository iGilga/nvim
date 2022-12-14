local M = {}

M.theme = 'kanagawa'

M.border = { ' ' }
M.style = 'solid'

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
    graphql = {
      opts = {
        autostart = false,
      },
    },
    html = {},
    jsonls = {
      opts = {
        autostart = false,
      },
    },
    -- marksman = {},
    sumneko_lua = {},
    tsserver = {
      formatting = false,
    },
    yamlls = {
      opts = {
        autostart = false,
      },
    },
  },
}

M.rename = {
  min_width = 40,
  border = {
    highlight = 'NuiBorder',
    style = M.style,
    title = ' Rename ',
    title_align = 'center',
    title_hl = 'NuiTitle',
  },
  prompt = '> ',
  prompt_hl = 'NuiPrompt',
  highlight = 'Normal:NuiNormal',
}

M.codeAction = {
  min_width = 40,
  border = {
    bottom_hl = 'NuiBottom',
    highlight = 'NuiBorder',
    style = M.style,
    title = ' Code Actions ',
    title_align = 'center',
    title_hl = 'NuiTitle',
  },
  separator = {
    char = ' ',
    text_align = 'center',
    highlight = 'NuiSeparator',
  },
  highlight = 'Normal:NuiNormal',
}

M.zettel = {
  min_width = 50,
  border = {
    bottom_hl = 'NuiBottom',
    highlight = 'NuiBorder',
    style = M.style,
    title = ' Zettelkasten ',
    title_align = 'center',
    title_hl = 'NuiTitle',
  },
  separator = {
    char = ' ',
    text_align = 'center',
    highlight = 'NuiSeparator',
  },
  highlight = 'Normal:NuiNormal',
}

M.plugins = {
  treesitter = {
    ensure_installed = {
      'bash',
      'c',
      'c_sharp',
      'cpp',
      'css',
      'dockerfile',
      'help',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'norg',
      'python',
      'rasi',
      'rust',
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
