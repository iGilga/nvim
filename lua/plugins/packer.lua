local present, packer = pcall(require, 'packer')

local first_install = false

if not present then
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  print('Cloning packer...')
  vim.fn.delete(install_path, 'rf')
  vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd('packadd packer.nvim')
  present, packer = pcall(require, 'packer')

  if present then
    print('packer.nvim cloned.')
    first_install = true
  else
    error('Cant clone packer.nvim.\nPacker path: ' .. install_path .. '\n' .. packer)
  end
end

packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end,
    prompt_border = 'rounded',
  },
  git = {
    clone_timeout = 800,
  },
})

return {
  packer = packer,
  first_install = first_install,
}
