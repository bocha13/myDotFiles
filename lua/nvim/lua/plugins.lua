vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- CONFIG PLUGINS HERE --
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{ 'nvim-lua/plenary.nvim' }}
  }
  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
  }
  use "windwp/nvim-autopairs"


  -- COLORSCHEMES AND STATUS BAR --
  use {'dracula/vim', as = 'dracula'}
  use "vim-airline/vim-airline"
  use "vim-airline/vim-airline-themes"

  -- LPS SERVERS --
  use "neovim/nvim-lspconfig"
  -- installer for LSP servers, :LspInstallInfo
  use "williamboman/nvim-lsp-installer"
  -- nvim-cmp config for lspconfig
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip"
end)
