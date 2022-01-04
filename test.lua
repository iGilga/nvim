local present, packer = pcall(require, 'packer')

if not present then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  print('Cloning packer...')
  vim.fn.delete(install_path, 'rf')
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd('packadd packer.nvim')
  present, packer = pcall(require, 'packer')

  if present then
    print('packer.nvim cloned successfully.')
  else
    error('Cant clone packer.nvim')
  end
end

local configLsp = function()
  local serversRange = {"html", "cssls", "denols", "vuels", "bashls", "yamlls", "jsonls", "sumneko_lua"}

  local lspconfig = require("lspconfig")

  local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true}

    function buf_map(bufnr, mode, lhs, rhs, opts)
      local options = { noremap = true, silent = true }
      if opts then
        options = merge(options, opts)
      end
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
    end

    function merge(...)
      return vim.tbl_deep_extend('force', ...)
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_map(bufnr, 'n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
    buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    buf_map(bufnr, 'n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')
    buf_map(bufnr, 'n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>')
    buf_map(bufnr, 'n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')

    -- diagnostics
    buf_map(bufnr, 'n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    buf_map(bufnr, 'n', ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    buf_map(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>')
    buf_map(bufnr, 'n', '<leader>ge', '<cmd>Telescope diagnostics bufnr=0<cr>')

    -- hover
    buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- formatting
    buf_map(bufnr, 'n', '<leader>gf', '<cmd>lua vim.lsp.buf.formatting()<cr>')
    buf_map(bufnr, 'v', '<leader>gf', '<cmd>lua vim.lsp.buf.range_formatting()<cr>')

    buf_map(bufnr, 'n', '<leader>wd', '<cmd>Telescope diagnostics<cr>')
    buf_map(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
    buf_map(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok then
    print('loaded cmp-nvim-lsp')
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end

  -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true

  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local serverConfig = {
    sumneko_lua = {
      -- cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = runtime_path
          },
          diagnostics = {
            globals = {"vim"}
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true)
          },
          telemetry = {
            enable = false
          }
        }
      }
    },
    lua = {}
  }

  local function setup_servers()
    for _, server in pairs(serversRange) do
      lspconfig[server].setup(
        serverConfig[server] or
          {
            on_attach = on_attach,
            capabilities = capabilities
          }
      )
    end
  end

  setup_servers()
end

local configCmp = function()
  local cmp = require('cmp')
  local ok, luasnip = pcall(require, 'luasnip')

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
          buffer = '[buf]',
          nvim_lsp = '[lsp]',
          nvim_lua = '[nvim_api]',
          path = '[path]',
          luasnip = '[snip]',
        },
      }),
    }
  end

  local opts = {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- disabled for autopairs mapping
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      },
    experimental = {
      ghost_text = true,
    },
    sources = {
      -- { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
      { name = 'luasnip' },
      { name = 'path' },
    },
    formatting = get_formatting(),
  }

  vim.cmd([[
    autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
  ]])

  cmp.setup(opts)
end

local configLuaship = function()
  local ok, ls = pcall(require, 'luasnip')

  if not ok then
    return {}
  end
  ls.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
  })

  ls.snipets = {
    all = {},
    html = {},
  }

  ls.snippets.javascript = ls.snippets.html
  ls.snippets.javascriptreact = ls.snippets.html
  ls.snippets.typescriptreact = ls.snippets.html

  require('luasnip/loaders/from_vscode').lazy_load({ include = { 'html' } })
end

packer.startup({
  function(use)
     -- packer.nvim
    use ({
      'wbthomason/packer.nvim',
      'nvim-lua/plenary.nvim',
    })

     -- lsp-config
    use {
      "neovim/nvim-lspconfig",
      config = configLsp(),
      requires = {
        { "williamboman/nvim-lsp-installer" },
      },
    }
    
     -- cmp
    use ({
      'hrsh7th/nvim-cmp',
      config = configCmp(),
      requires = {
        { 'onsails/lspkind-nvim' },
        { 'L3MON4D3/LuaSnip',
          config = configLuaship(),
          requires = {
            'rafamadriz/friendly-snippets',
          },
        },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp', after = 'cmp-nvim-lua' },
      },
    })
    -- use { 'onsails/lspkind-nvim' }
    -- use { 'L3MON4D3/LuaSnip',
    --   config = configLuaship(),
    --   requires = {
    --     'rafamadriz/friendly-snippets',
    --   },
    -- }
    -- use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    -- use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    -- use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
    -- use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    -- use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})

-- local ok, present = pcall(require, 'cmp_nvim_lsp')
-- if ok then
--   print('Load')
--   else
--   print('cant load')
-- end
