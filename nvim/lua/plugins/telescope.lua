local telescope_utils = require("utils").telescope_utils

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Telescope",
		version = false,
		keys = {
			-- find
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>ff", telescope_utils("files"), desc = "Find Files (root dir)" },
			{ "<leader>fg", telescope_utils(), desc = "Find Files (repo)" },
			-- search
			{ "<leader>sg", telescope_utils("live_grep"), desc = "Grep (root dir)" },
			-- git
			-- { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
				file_ignore_patterns = { "node_modules" },
				initial_mode = "insert",
				-- selection_strategy = "reset",
				sorting_strategy = "descending",
				use_less = true,
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			},
		},
	},
}
