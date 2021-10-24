local nullls = require("null-ls")

local denofmt = {
  method = nullls.methods.FORMATTING,
  filetypes = {"javascipt, javascriptreact, javascript.jsx"},
  generator = nullls.formatter({
    command = "deno",
    --args = { "fmt", "-"},
    to_stdin = true
  }),
}

nullls.config {
  debounce = 150,
  save_after_format = false,
  sources = { denofmt }
}

require("lspconfig")["null-ls"].setup({})
