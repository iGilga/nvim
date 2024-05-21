local function foldTextFormatter(virtText, lnum, endLnum, width, truncate)
  local hlgroup = 'NonText'
  local newVirtText = {}
  local suffix = '  󰘕 ' .. tostring(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, hlgroup })
  return newVirtText
end

return {
  {
    'chrisgrieser/nvim-origami',
    event = 'BufReadPost',
    keys = function()
      local origami = require('origami')
      return {
        { '<A>h', origami.h },
        { '<A>l', origami.l }
      }
    end,
    opts = {
      setupFoldKeymaps = false
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'VimEnter',
    keys = function()
      local ufo = require('ufo')
      return {
        { 'zm', ufo.closeAllFolds,                                                       desc = '[ufo] close all folds' },
        { 'zk', ufo.goPreviousClosedFold,                                                desc = '[ufo] goto prev fold' },
        { 'zj', ufo.goNextClosedFold,                                                    desc = '[ufo] goto next fold' },
        { 'ze', function() return ufo.openFoldsExceptKinds { 'comment', 'imports' } end, desc = '[ufo] open all folds' },
        { 'zr', function() return ufo.openFoldsExceptKinds {} end,                       desc = '[ufo] open all folds' },
        { 'z1', function() return ufo.closeFoldsWith(1) end,                             desc = '[ufo] close l1 folds' },
        { 'z2', function() return ufo.closeFoldsWith(2) end,                             desc = '[ufo] close l1 folds' },
        { 'z3', function() return ufo.closeFoldsWith(3) end,                             desc = '[ufo] close l1 folds' },
        { 'z4', function() return ufo.closeFoldsWith(4) end,                             desc = '[ufo] close l1 folds' },
        { 'z5', function() return ufo.closeFoldsWith(5) end,                             desc = '[ufo] close l1 folds' },
        { 'z6', function() return ufo.closeFoldsWith(6) end,                             desc = '[ufo] close l1 folds' },
        { 'z7', function() return ufo.closeFoldsWith(7) end,                             desc = '[ufo] close l1 folds' },
        { 'z8', function() return ufo.closeFoldsWith(8) end,                             desc = '[ufo] close l1 folds' },
        { 'z9', function() return ufo.closeFoldsWith(9) end,                             desc = '[ufo] close l1 folds' },
      }
    end,
    init = function()
      -- vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = {
      provider_selector = function(_, ft, _)
        local lspwithOutFolding = { 'markdown', 'sh', 'css', 'html' }
        if vim.tbl_contains(lspwithOutFolding, ft) then
          return { 'treesitter', 'indent' }
        end
        return { 'lsp', 'indent' }
      end,
      close_fold_kinds_for_ft = {
        -- default = { 'imports', 'comment' }
      },
      open_fold_hl_timeout = 800,
      fold_virt_text_handler = foldTextFormatter,
    }
  }
}
