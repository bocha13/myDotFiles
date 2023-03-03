local function get_root()
	local path = vim.api.nvim_buf_get_name(0)
	path = path ~= "" and vim.loop.fs_realpath(path) or nil
	local roots = {}
	if path then
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			local workspace = client.config.workspace_folders
			local paths = workspace
					and vim.tbl_map(function(ws)
						return vim.uri_to_fname(ws.uri)
					end, workspace)
				or client.config.root_dir and { client.config.root_dir }
				or {}
			for _, p in ipairs(paths) do
				local r = vim.loop.fs_realpath(p)
				if path:find(r, 1, true) then
					roots[#roots + 1] = r
				end
			end
		end
	end
	table.sort(roots, function(a, b)
		return #a > #b
	end)
	local root = roots[1]
	if not root then
		path = path and vim.fs.dirname(path) or vim.loop.cwd()
		root = vim.fs.find({ ".git", "lua" }, { path = path, upward = true })[1]
		root = root and vim.fs.dirname(root) or vim.loop.cwd()
	end
	return root
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = get_root() })
			end,
			desc = "Explorer NeoTree (root dir)",
		},
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			enable_diagnostics = true,
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
}
