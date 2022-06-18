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
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
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
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Smart and Powerful commenting plugin for neovim
	use("kyazdani42/nvim-web-devicons") -- This plugin provides the same icons as well as colors for each icon
	use({ "kyazdani42/nvim-tree.lua" }) -- A File Explorer For Neovim Written In Lua
	use("akinsho/bufferline.nvim") -- A  buffer line for Neovim built using lua
	use("moll/vim-bbye") -- Allows you to do delete buffers without closing your windows or messing up your layout
	use("nvim-lualine/lualine.nvim") --A blazing fast and easy to configure Neovim statusline written in Lua
	use("akinsho/toggleterm.nvim")  -- A neovim plugin to persist and toggle multiple terminals during an editing session
	use("ahmedkhalf/project.nvim") -- An all in one neovim plugin written in lua that provides superior project management
	use("lewis6991/impatient.nvim") -- Improve startup time
	use("lukas-reineke/indent-blankline.nvim") -- Adds indentation guides to all lines (including empty lines)
	use("goolord/alpha-nvim") -- A fast and fully customizable greeter for neovim
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

	-- Colorschemes
	use("folke/tokyonight.nvim")
  	use("bluz71/vim-moonfly-colors")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("RRethy/vim-illuminate") -- Automatically highlighting other uses of the current word under the cursor

	-- Telescope
	use("nvim-telescope/telescope.nvim") -- Extendable fuzzy finder over lists

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- Git
	use("lewis6991/gitsigns.nvim") -- Super fast git decorations

	-- DAP
	use("mfussenegger/nvim-dap") -- A Debug Adapter Protocol client implementation for Neovim
	use("rcarriga/nvim-dap-ui") -- UI for dap
	use("ravenxrz/DAPInstall.nvim") -- A NeoVim plugin for managing several debuggers for Nvim-dap

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
