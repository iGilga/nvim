local nnoremap = require("utils.keymap").nnoremap

vim.g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_respect_buf_cwd = 1

require("nvim-tree").setup {
  auto_close = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  }
}

nnoremap {"<c-t>", "<cmd>:NvimTreeToggle<cr>"}
