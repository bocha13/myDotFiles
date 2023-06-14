return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			on_colors = function(c)
				c.gitSigns = {
					add = "#8fc28c",
					change = "#7495d1",
					delete = "#f38ba8",
				}
			end,
		},
	},
	-- Configure LazyVim to load the colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "tokyonight",
		},
	},
}
