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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

local config = function(name)
	return string.format("require('plugins.%s')", name)
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("kyazdani42/nvim-web-devicons") -- This plugin provides the same icons as well as colors for each icon	
  use("moll/vim-bbye") -- Allows you to do delete buffers without closing your windows or messing up your layout
  use("lukas-reineke/indent-blankline.nvim") -- Adds indentation guides to all lines (including empty lines)
  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("lewis6991/gitsigns.nvim") -- Super fast git decorations
  use("L3MON4D3/LuaSnip") -- Snippet engine
  use("rafamadriz/friendly-snippets") -- A bunch of snippets to use

	-- Highlight other uses of current word under cursor
  use({
    "RRethy/vim-illuminate",
    config = config("illuminate"),
  }) 

  -- Greeter for nvim
  use({
    "goolord/alpha-nvim",
    config = config("alpha"),
  })
  
  -- persist multiple terminals
	use({
    "akinsho/toggleterm.nvim",
    config = config("toggleterm"),
  })
  
  -- Status Line
  use({
    "nvim-lualine/lualine.nvim",
    config = config("lualine")
  })

  -- Bufferline
  use({
    "akinsho/bufferline.nvim",
    config = config("bufferline"),
  })
  
  -- NVIM-TREE, a file explorer
  use({ 
    "kyazdani42/nvim-tree.lua",
    config = config("nvim-tree"),
  })

  -- Autopairs, integrates with both cmp and treesitter
  use({
		"windwp/nvim-autopairs",
		config = config("autopairs"),
	})

  -- cmp plugins
	use({
    "hrsh7th/nvim-cmp",
    config = config("cmp"),
  }) 

  -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

  -- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
    config = config("treesitter")
	})

  -- Comment, smart and powerfull commenting plugin
	use({
    "numToStr/Comment.nvim",
    config = config("comment"),
  })

	-- Colorschemes
	use({
		"martinsione/darkplus.nvim",
		config = config("colorscheme"),
	})
  
  -- Telescope, fuzzy finder
  use({
    "nvim-telescope/telescope.nvim",
    config = config("telescope"),
  })

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

  -- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
