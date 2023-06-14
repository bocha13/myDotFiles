return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = {
				diagnostics = {
					Error = "E ",
					Warn = "W ",
					Hint = "H ",
					Info = "I ",
				},
				git = {
					added = " ",
					modified = " ",
					removed = " ",
				},
			}

			return {
				options = {
					icons_enabled = true,
					theme = "auto",
					globalstatus = false,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					disabled_filetypes = { statusline = { "dashboard", "lazy" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						-- show filename, type, icon and path in statusline
						-- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{
							"filename",
							path = 1,
							symbols = {
								modified = "[+]",
								readonly = "[-]",
								unnamed = "[No Name]",
								newfile = "[New]",
							},
						},
					},
					lualine_x = {
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						-- function()
						--   return " " .. os.date("%R")
						-- end,
					},
				},
			}
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { hl = "GitSignsAdd", text = "█", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = {
					hl = "GitSignsChange",
					text = "█",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = {
					hl = "GitSignsDelete",
					text = "~",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				topdelete = {
					hl = "GitSignsDelete",
					text = "~",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "█",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				untracked = { text = "█" },
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			close_if_last_window = true,
		},
	},
}
