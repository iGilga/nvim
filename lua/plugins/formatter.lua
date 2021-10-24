local nnoremap = require("utils.keymap").nnoremap

require("formatter").setup {
  filetype = {
   lua = {
      -- luafmt
      function()
        return {
          exe = "luafmt",
          args = {"--indent-count", 2, "--stdin"},
          stdin = true
        }
      end
    }
  }
}

--nnoremap {"<leader>f", "<cmd>:Format<cr>", { silent = true }}
