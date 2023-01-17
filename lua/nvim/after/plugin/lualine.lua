local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- local status_theme_ok, theme = pcall(require, "lualine.themes.seoul256")
-- if not status_theme_ok then
-- return
-- end

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
	-- color = function()
	-- 	-- auto change color according to neovims mode
	-- 	return { bg = mode_color[vim.fn.mode()], fg = "#262626" }
	-- end,
	padding = 0,
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = "E ", warn = "W " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
	separator = "| ",
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
	-- color = function()
	-- 	return { fg = mode_color[vim.fn.mode()], bg = "#262626" }
	-- end,
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
	separator = " |",
}

local location = {
	"location",
	-- color = function()
	-- 	return { fg = "#252525", bg = mode_color[vim.fn.mode()] }
	-- end,
}

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "moonfly",
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
   },
    ignore_focus = {},
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
