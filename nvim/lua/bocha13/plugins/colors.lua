return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				integrations = {
					telescope = true,
					cmp = true,
					gitsigns = true,
					neotree = true,
				},
				color_overrides = {
					flavour = "mocha",
					mocha = {
						base = "#191724",
						mantle = "#2b2b3c",
						crust = "#2b2b3c",
					},
				},
				highlight_overrides = {
					mocha = {
						NeoTreeNormal = { bg = "#191724" },
						NeoTreeNormalNC = { bg = "#191724" },
						TelescopeBorder = { fg = "#c8aaad" },
						GitSignsAdd = { fg = "#8fc28c" },
						GitSignsChange = { fg = "#7495d1" },
						GitSignsDelete = { fg = "#f38ba8" },
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
