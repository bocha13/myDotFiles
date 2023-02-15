return {
	{
		"williamboman/mason.nvim",
		config = function()
			local mason = require("mason")
			local mason_lsp = require("mason-lspconfig")
			local mason_null_ls = require("mason-null-ls")

			local config = {
				virtual_text = { spacing = 4, prefix = "●" },
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
				},
			}

			vim.diagnostic.config(config)
			mason.setup()

			mason_lsp.setup({
				ensure_installed = {
					"sumneko_lua",
					"rust_analyzer",
					"tsserver",
					"eslint",
				},
				automatic_installation = true,
			})

			mason_null_ls.setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"eslint_d",
				},
			})
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jay-babu/mason-null-ls.nvim" },
	{ "simrat39/rust-tools.nvim" },
}