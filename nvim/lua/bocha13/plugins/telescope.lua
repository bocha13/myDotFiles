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
		},
	},
}
