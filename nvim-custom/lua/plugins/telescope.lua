local telescope_utils = require("utils").telescope_utils

return {
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
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
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
			-- use_less = true,
			-- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		},
		-- pickers = {
		--
		-- 	live_grep = {
		-- 		theme = "dropdown",
		-- 	},
		-- 	grep_string = {
		-- 		theme = "dropdown",
		-- 	},
		-- 	find_files = {
		-- 		theme = "dropdown",
		-- 	},
		-- 	buffers = {
		-- 		theme = "dropdown",
		-- 		initial_mode = "normal",
		-- 	},
		-- 	planets = {
		-- 		show_pluto = true,
		-- 		show_moon = true,
		-- 	},
		-- 	colorscheme = {
		-- 		-- enable_preview = true,
		-- 	},
		-- 	lsp_references = {
		-- 		theme = "dropdown",
		-- 		initial_mode = "normal",
		-- 	},
		-- 	lsp_definitions = {
		-- 		theme = "dropdown",
		-- 		initial_mode = "normal",
		-- 	},
		-- 	lsp_declarations = {
		-- 		theme = "dropdown",
		-- 		initial_mode = "normal",
		-- 	},
		-- 	lsp_implementations = {
		-- 		theme = "dropdown",
		-- 		initial_mode = "normal",
		-- 	},
		-- },
	},
}
