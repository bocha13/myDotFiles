local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- BARBAR
  use 'nvim-tree/nvim-web-devicons'
  use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}

  use("RRethy/vim-illuminate")

  -- tmux navigation
  use("christoomey/vim-tmux-navigator")

  -- Status Line
  use("nvim-lualine/lualine.nvim")

  use("WhoIsSethDaniel/toggle-lsp-diagnostics.nvim")

  -- TABNINE
  use({
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  })

  -- Comment, smart and powerfull commenting plugin
  use("numToStr/Comment.nvim")

  use({
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })

  -- indentation lines
  use("lukas-reineke/indent-blankline.nvim")
  -- Git Signs
  use("lewis6991/gitsigns.nvim")

  -- Autopairs, integrates with both cmp and treesitter
  use("windwp/nvim-autopairs")

  -- Colorscheme
  use('folke/tokyonight.nvim')

  -- Neogit
  use(
    { "TimUntersberger/neogit",
      requires = "nvim-lua/plenary.nvim"
    })

  -- Diffview
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use('simrat39/rust-tools.nvim')

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

end)
