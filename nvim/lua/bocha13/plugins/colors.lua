return {
  {
  	"folke/tokyonight.nvim",
  	lazy = false,
  	priority = 1000,
  	config = function()
  		require("tokyonight").setup({
  			style = "night",
  			on_colors = function(c)
  				c.gitSigns = {
  					add = "#8fc28c",
  					change = "#7495d1",
  					delete = "#f38ba8",
  				}
  			end,
  		})
  		vim.cmd.colorscheme("tokyonight")
  	end,
  },
}
