return {
	"folke/tokyonight.nvim",
	config = function()
		require("tokyonight").setup({
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
			end,
			on_highlights = function(highlight, c)
				highlight.NeoTreeNormal = {
					bg = c.bg,
					fg = "#a9b1d6",
				}
				highlight.NeoTreeStatusLine = {
					bg = "#242b38",
					fg = "#a9b1d6",
				}
				highlight.NeoTreeNormalNC = {
					bg = c.bg,
					fg = "#a9b1d6",
				}
				highlight.NeoTreeWinSeparator = {
					bg = c.bg,
					fg = "#458588",
				}
				highlight.BufferTabpageFill = {
					bg = "#1c1c1c",
					fg = "#737aa2",
				}
				highlight.BufferInactive = {
					bg = "#1c1c1c",
					fg = "#737aa2",
				}
				highlight.BufferOffset = {
					bg = "#1c1c1c",
					fg = "#458588",
				}
				highlight.BufferInactiveSign = {
					bg = "#1c1c1c",
					fg = "#458588",
				}
				highlight.BufferCurrentSign = {
					bg = "#3b4261",
					fg = "#458588",
				}
				highlight.MsgArea = {
					bg = c.bg,
					fg = "#60b2a5",
				}
			end,
		})
		vim.cmd.colorscheme("tokyonight")
	end,
}
