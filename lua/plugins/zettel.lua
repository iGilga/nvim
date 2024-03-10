return {
  {
    'mickael-menu/zk-nvim',
    cmd = {
      'ZkBacklinks',
      'ZkIndex',
      'ZkLinks',
      'ZkNew',
      'ZkNewFromContentSelection',
      'ZkNewFromTitleSelection',
      'ZkNotes',
      'ZkTags',
    },
    config = function()
      require('zk').setup({
        picker = 'select',
        lsp = {
          cmd = { 'zk', 'lsp' },
          name = 'zk',
        },

        auto_attach = { enabled = true, filetype = { 'markdown' } },
      })
    end,
  },
  -- telescope-zettel
  {
    'https://gitlab.com/thlamb/telescope-zettel.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      require('telescope').setup({
        extensions = {
          zettel = {
            zk_path = '~/Documents/Zettel',
            link_style = 'md',  -- or "md"
            remove_ext = false, -- or false
          },
        },
      })
      require('telescope').load_extension('zettel')
    end,
    enabled = false,
  },
}
