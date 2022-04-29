local ok, packer = pcall(require, 'packer')

local first_install = false

if not ok then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  print('Cloning packer...')
  vim.fn.delete(install_path, 'rf')
  vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd('packadd packer.nvim')
  ok, packer = pcall(require, 'packer')

  if ok then
    print('packer.nvim cloned.')
    first_install = true
  else
    error('Cant clone packer.nvim.\nPacker path: ' .. install_path .. '\n' .. packer)
  end
end

local config = require('config')

packer.init({
  -- compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
  -- compile_on_sync = true,
  -- auto_clean = true,
  display = {
    open_fn = function()
      return require('packer.util').float({ border = config.border })
    end,
    prompt_border = config.border,
  },
  git = {
    clone_timeout = 10000,
  },
})

return {
  packer = packer,
  first_install = first_install,
}
