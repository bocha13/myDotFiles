return {
	"folke/tokyonight.nvim",
	config = function()
		require("tokyonight").setup({
			style = "moon",
			on_colors = function(colors)
				colors.bg = "#1e2030"
				-- colors.bg_visual = "#292e42"
				-- colors.bg_dark = "#1c1c1c"
				-- colors.bg_float = "#1c1c1c"
				-- colors.bg_popup = "#1c1c1c"
				-- colors.bg_sidebar = "#1c1c1c"
				colors.bg_statusline = "#161824"
				colors.border = "#65bcff"
			end,
			on_highlights = function(highlight, c)
				highlight.BufferTabpageFill = {
					bg = c.bg_statusline,
					fg = "#3b4261",
				}
				highlight.BufferOffset = {
					bg = c.bg_statusline,
					fg = "#65bcff",
				}
				highlight.BufferInactiveSign = {
					bg = "#161824",
					fg = "#65bcff",
				}
				highlight.BufferCurrentSign = {
					bg = "#3b4261",
					fg = "#65bcff",
				}
				highlight.MsgArea = {
					bg = c.bg,
					fg = "#65bcff",
				}
			end,
		})
		vim.cmd.colorscheme("tokyonight")
	end,
}
