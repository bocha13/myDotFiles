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
	-- Source config files
	local config = function(name)
		return string.format("require('plugins.%s')", name)
	end

	local use_with_config = function(path, name)
		use({ path, config = config(name) })
	end

	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("moll/vim-bbye") -- Allows you to do delete buffers without closing your windows or messing up your layout
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("L3MON4D3/LuaSnip") -- Snippet engine
	use("rafamadriz/friendly-snippets") -- A bunch of snippets to use

	-- Icons
	use({
		"kyazdani42/nvim-web-devicons",
		config = config("nvim-webdev-icons"),
	})

	-- add indentation guides to all lines
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = config("indentline"),
	})

	-- Git Signs
	use({
		"lewis6991/gitsigns.nvim",
		config = config("gitsigns"),
	})

	-- Neogit
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })

	-- Diffview
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Improve startup
	use({
		"lewis6991/impatient.nvim",
		config = config("impatient"),
	})

	-- Highlight other uses of current word under cursor
	use("RRethy/vim-illuminate")

	-- Greeter for nvim
	use({
		"goolord/alpha-nvim",
		config = config("alpha"),
	})

	-- persist multiple terminals
	use({
		config = config("toggleterm"),
		"akinsho/toggleterm.nvim",
	})

	-- Status Line
	use({
		"nvim-lualine/lualine.nvim",
		config = config("lualine"),
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
		config = config("treesitter"),
	})

	-- Comment, smart and powerfull commenting plugin
	use({
		"numToStr/Comment.nvim",
		config = config("comment"),
	})

	-- Colorschemes
	use({
		"haishanh/night-owl.vim",
		config = config("colorscheme"),
	})

	-- TABNINE
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		config = config("tabnine"),
	})

	-- Copilot
	-- first install this plugin, to config copilot
	-- once installed, comment it out and use the other two
	-- use("github/copilot.vim") -- Provides autocomplete-style suggestions from an AI pair programmer as you code
	--	use({
	--		"zbirenbaum/copilot.lua",
	--		event = { "VimEnter" },
	--		-- config = config("copilot"),
	--		config = function()
	--			vim.defer_fn(function()
	--				require("copilot").setup()
	--			end, 100)
	--		end,
	--	})
	--	use({
	--		"zbirenbaum/copilot-cmp",
	--		module = "copilot_cmp",
	--	})

	-- Telescope, fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		config = config("telescope"),
	})

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("simrat39/rust-tools.nvim") -- rust tools?

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
