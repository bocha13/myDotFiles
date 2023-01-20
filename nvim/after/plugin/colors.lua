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
	end,
  on_highlights = function(highlight, c)
    highlight.NvimTreeNormal = {
      bg = c.bg,
      fg = '#a9b1d6'
    }
    highlight.NvimTreeStatusLine = {
      bg = "#303030",
      fg = '#a9b1d6'
    }
    highlight.NvimTreeNormalNC = {
      bg = c.bg,
      fg = '#a9b1d6'
    }
    highlight.NvimTreeWinSeparator = {
      bg = c.bg,
      fg = '#458588'
    }
    highlight.BufferTabpageFill = {
      bg = "#303030",
      fg = '#737aa2'
    }
    highlight.BufferInactive = {
      bg = c.bg,
      fg = '#737aa2'
    }
    highlight.MsgArea = {
      bg = c.bg,
      fg = '#60b2a5'
    }
  end
})

vim.cmd.colorscheme("tokyonight")
