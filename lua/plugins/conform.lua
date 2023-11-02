return { {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  cmd = {
    'MasonToolsInstall', 'MasonToolsUpdate', 'MasonToolsClean'
  },
  event = { 'BufWritePre' },
  opts = {
    ensure_installed = {
      'prettierd',
      'shfmt',
    }
  },
  config = function(_, opts)
    require('mason-tool-installer').setup(opts)
  end
}, {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = 'ConformInfo',
  init = function()
    vim.api.nvim_create_user_command("ConFormat", function()
      require('conform').format({ async = true, lsp_fallback = true })
    end, {})

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autofarmat = true
      else
        vim.g.disable_autofarmat = true
      end
    end, {
      desc = "Disable autoformat-on-save", bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autofarmat = false
      vim.g.disable_autofarmat = false
    end, {
      desc = "Re-enable autoformat-on-save"
    })

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      sh = { 'shfmt' },
    },
    format_on_save = function(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") then
        return
      end
      if vim.g.disable_autofarmat or vim.b.disable_autofarmat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters = {
      -- prettierd = {}
    }
  },
  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)
    -- conform.formatters.shfmt = {
    --
    -- }
  end
} }
