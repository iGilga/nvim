return {
  'numToStr/Comment.nvim',
  event = 'BufReadPre',
  lazy = false,
  opts = {
    pre_hook = function()
      require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    end
  },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
    }
  }
}
