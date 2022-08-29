local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
	"cssls",
	"cssmodules_ls",
	"html",
	"jsonls",
	"sumneko_lua",
	"tsserver",
	"pyright",
	"yamlls",
	"bashls",
	"rust_analyzer",
	"clangd",
}

local settings = {
	ensure_installed = servers,
	-- automatic_installation = false,
	ui = {
		icons = {
			server_installed = "◍",
			server_pending = "◍",
			server_uninstalled = "◍",
			-- server_installed = "✓",
			-- server_pending = "➜",
			-- server_uninstalled = "✗",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
		},
	},

	log_level = vim.log.levels.INFO,
	-- max_concurrent_installers = 4,
	-- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
}

lsp_installer.setup(settings)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	if server == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "tsserver" then
		local tsserver_opts = require("lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

	if server == "rust_analyzer" then
    local rust_opts = require("lsp.settings.rust")
    require("rust-tools").setup(rust_opts)
    goto continue
	end

	lspconfig[server].setup(opts)
  ::continue::
end
