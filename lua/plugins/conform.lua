return {
  {
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

    vim.api.nvim_create_user_command("FormatToggle", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.notify(('Autoformat: %s'):format(tostring(not vim.g.disable_autoformat)), 2)
    end, { desc = "Toggleable autoformat" })

    -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
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
      if vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters = {
      shfmt = {
        inherit = false,
        command = "shfmt",
        args = { "-i", "2", "-filename", "$FILENAME" },
      }
    }
  },
} }
