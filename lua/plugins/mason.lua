return {
  'williamboman/mason.nvim',
  cmd = {
    'Mason',
    'MasonInstall',
    'MasonLog',
    'MasonUninstall',
    'MasonUninstallAll',
  },
  config = function()
    require('mason').setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })
  end,
}
