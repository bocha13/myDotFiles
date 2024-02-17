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
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" } },
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
	},
}
