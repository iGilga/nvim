return {
  'williamboman/mason.nvim',
  event = 'BufReadPre',
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
