local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
	padding = 0,
}

local function is_neotree_open()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "ft") == "neo-tree" then
			return require("bufferline.api").set_offset(35, "             Explorer")
		end
	end
	return require("bufferline.api").set_offset(0)
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWipeout" }, {
	pattern = "*",
	callback = function()
		is_neotree_open()
	end,
})

return {
	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(plugin)
			local icons = {
				diagnostics = {
					Error = " ",
					Warn = " ",
					Hint = " ",
					Info = " ",
				},
				git = {
					added = " ",
					modified = " ",
					removed = " ",
				},
			}
			local function fg(name)
				return function()
					local hl = vim.api.nvim_get_hl_by_name(name, true)
					return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
				end
			end

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
				},
				sections = {
					lualine_a = { mode },
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
						-- { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {
						{
							function()
								return require("noice").api.status.command.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.command.has()
							end,
							color = fg("Statement"),
						},
						{
							function()
								return require("noice").api.status.mode.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.mode.has()
							end,
							color = fg("Constant"),
						},
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = fg("Special"),
						},
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
						{ "progress", separator = "", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
			}
		end,
	},

	-- Neo-Tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				enable_diagnostics = false,
				source_selector = {
					winbar = true,
					content_layout = "center",
					tab_labels = {
						filesystem = " File",
						buffers = "➜ Buffs",
						git_status = " Git",
						diagnostics = "",
					},
				},
				default_component_configs = {
					indent = {
						padding = 0,
					},
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "",
					},
					git_status = {
						symbols = {
							added = "",
							deleted = "",
							modified = "",
							renamed = "",
							untracked = "",
							ignored = "",
							unstaged = "",
							staged = "",
							conflict = "",
						},
					},
				},
				window = {
					width = 35,
					mappings = {
						["o"] = "open",
						["v"] = "open_vsplit",
					},
				},
				filesystem = {
					follow_current_file = true,
					hijack_netrw_behavior = "open_current",
					use_libuv_file_watcher = true,
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = true,
					},
				},
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function(_)
							vim.opt_local.signcolumn = "auto"
						end,
					},
				},
			})
		end,
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},

	-- active indent guide and indent text objects
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "BufReadPre",
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
			require("mini.indentscope").setup(opts)
		end,
	},

	-- barbar
	{
		"romgrk/barbar.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				-- Enable/disable animations
				animation = false,

				-- Enable/disable auto-hiding the tab bar when there is a single buffer
				auto_hide = false,

				-- Enable/disable current/total tabpages indicator (top right corner)
				tabpages = true,

				-- Enable/disable close button
				closable = true,

				-- Enables/disable clickable tabs
				--  - left-click: go to buffer
				--  - middle-click: delete buffer
				clickable = true,

				-- Enables / disables diagnostic symbols
				diagnostics = {
					-- you can use a list
					{ enabled = true, icon = "ﬀ" }, -- ERROR
					{ enabled = false }, -- WARN
					{ enabled = false }, -- INFO
					{ enabled = true }, -- HINT

					-- OR `vim.diagnostic.severity`
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
					[vim.diagnostic.severity.WARN] = { enabled = false },
					[vim.diagnostic.severity.INFO] = { enabled = false },
					[vim.diagnostic.severity.HINT] = { enabled = true },
				},

				-- Excludes buffers from the tabline
				-- exclude_ft = { "javascript" },
				-- exclude_name = { "package.json" },

				-- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
				-- hide = { extensions = true, inactive = true },

				-- Disable highlighting alternate buffers
				highlight_alternate = false,

				-- Disable highlighting file icons in inactive buffers
				highlight_inactive_file_icons = false,

				-- Enable highlighting visible buffers
				highlight_visible = true,

				-- Enable/disable icons
				-- if set to 'numbers', will show buffer index in the tabline
				-- if set to 'both', will show buffer index and icons in the tabline
				icons = true,

				-- If set, the icon color will follow its corresponding buffer
				-- highlight group. By default, the Buffer*Icon group is linked to the
				-- Buffer* group (see Highlighting below). Otherwise, it will take its
				-- default value as defined by devicons.
				icon_custom_colors = false,

				-- Configure icons on the bufferline.
				icon_separator_active = "▎",
				icon_separator_inactive = "▎",
				icon_close_tab = "",
				icon_close_tab_modified = "●",
				icon_pinned = "車",

				-- If true, new buffers will be inserted at the start/end of the list.
				-- Default is to insert after current buffer.
				insert_at_end = false,
				insert_at_start = false,

				-- Sets the maximum padding width with which to surround each tab
				maximum_padding = 1,

				-- Sets the minimum padding width with which to surround each tab
				minimum_padding = 1,

				-- Sets the maximum buffer name length.
				maximum_length = 30,

				-- If set, the letters for each buffer in buffer-pick mode will be
				-- assigned based on their name. Otherwise or in case all letters are
				-- already assigned, the behavior is to assign letters in order of
				-- usability (see order below)
				semantic_letters = true,

				-- New buffer letters are assigned in this order. This order is
				-- optimal for the qwerty keyboard layout but might need adjustement
				-- for other layouts.
				letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

				-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
				-- where X is the buffer number. But only a static string is accepted here.
				no_name_title = nil,
			})
		end,
	},
}
