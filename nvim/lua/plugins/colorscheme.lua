return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "night",
	-- 			on_colors = function(c)
	-- 				c.gitSigns = {
	-- 					add = "#8fc28c",
	-- 					change = "#7495d1",
	-- 					delete = "#f38ba8",
	-- 				}
	-- 			end,
	-- 		})
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },
	{

		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "mix"
			vim.g.gruvbox_material_diagnostic_line_highlight = 1
			vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
			vim.cmd.colorscheme("gruvbox-material")

			vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
			vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
			vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
		end,
	},
}
