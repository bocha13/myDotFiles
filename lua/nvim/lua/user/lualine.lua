local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- local status_theme_ok, theme = pcall(require, "lualine.themes.jellybeans")
-- if not status_theme_ok then
-- return
-- end

local mode_color = {
	n = "#7AA2F7",
	i = "#9ECE6A",
	v = "#BB9AF7",
	[""] = "#BB9AF7",
	V = "#BB9AF7",
	-- c = '#B5CEA8',
	-- c = '#D7BA7D',
	c = "#E0AF68",
	no = "#7AA2F7",
	s = "#ce9178",
	S = "#ce9178",
	ic = "#dcdcaa",
	R = "#F7768E",
	Rv = "#F7768E",
	cv = "#7AA2F7",
	ce = "#7AA2F7",
	r = "#F7768E",
	rm = "#E0AF68",
	["r?"] = "#E0AF68",
	["!"] = "#E0AF68",
	t = "#D7BA7D",
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
	color = function()
		-- auto change color according to neovims mode
		return { bg = mode_color[vim.fn.mode()], fg = "#303030" }
	end,
	padding = 0,
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
	separator = " │ ",
}

local filetype = {
	"filetype",
	icons_enabled = true,
	-- icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = " ",
	colored = false,
}

local progress = {
	"progress",
	-- color = "SLProgress",
}

local spaces = {
	function()
		return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	end,
	padding = 0,
	separator = " | ",
}

local location = {
	"location",
	color = function()
		return { fg = "#252525", bg = mode_color[vim.fn.mode()] }
	end,
}

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode, branch },
		lualine_b = { diagnostics },
		lualine_x = { diff, spaces, filetype },
		lualine_y = { progress },
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
