return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = "Telescope",
	version = false,
	opts = {
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			file_ignore_patterns = { "node_modules" },
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "descending",
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			use_less = true,
		},
	},
}
