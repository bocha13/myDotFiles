return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
		config = true,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
	},
	{
		"tpope/vim-fugitive",
		event = "BufWinEnter",
		-- cmd = {
		-- 	"G",
		-- 	"Git",
		-- 	"Gdiff",
		-- 	"Gdiffsplit",
		-- 	"Gread",
		-- 	"Gwrite",
		-- 	"Ggrep",
		-- 	"GMove",
		-- 	"GDelete",
		-- 	"GBrowse",
		-- },
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
	},
}
