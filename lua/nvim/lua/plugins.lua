vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{ 'nvim-lua/plenary.nvim' }}
  }
  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
  }
  use {'dracula/vim', as = 'dracula'}
end)
