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
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
	},
}
