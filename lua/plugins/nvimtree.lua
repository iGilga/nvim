local nnoremap = require("utils.keymap").nnoremap

vim.g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
vim.g.nvim_tree_indent_markers = 1

require("nvim-tree").setup {
  auto_close = true
}

nnoremap {"<c-t>", "<cmd>:NvimTreeToggle<cr>"}
