require'tokyonight'.setup({
	style = "night",
	on_colors = function(colors)
		colors.bg = "#161616"
		colors.bg_visual = "#292e42"
		colors.bg_dark = "#1c1c1c"
		colors.bg_float = "#1c1c1c"
		colors.bg_popup = "#1c1c1c"
		colors.bg_sidebar = "#1c1c1c"
		colors.bg_statusline = "#1c1c1c"
    colors.border = "#458588"
	end
})

vim.cmd.colorscheme("tokyonight")
