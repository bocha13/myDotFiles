return {
	-- LSP support
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs = { Error = "E", Warn = "W", Hint = "H", Info = "E" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- configure tsserver
			lspconfig["tsserver"].setup({
				capabilities = capabilities,
			})

			-- configure .prisma server
			lspconfig["prismals"].setup({
				capabilities = capabilities,
			})

			-- configure rust_analyzer server
			lspconfig["rust_analyzer"].setup({
				capabilities = capabilities,
				cmd = {
					"rustup",
					"run",
					"stable",
					"rust-analyzer",
				},
			})

			-- configure gopls
			lspconfig["gopls"].setup({
				capabilities = capabilities,
			})

			-- configure lua server (with special settings)
			-- lspconfig["sumneko_lua"].setup({
			-- 	capabilities = capabilities,
			-- 	settings = { -- custom settings for lua
			-- 		Lua = {
			-- 			-- make the language server recognize "vim" global
			-- 			diagnostics = {
			-- 				globals = { "vim" },
			-- 			},
			-- 			workspace = {
			-- 				-- make language server aware of runtime files
			-- 				library = {
			-- 					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
			-- 					[vim.fn.stdpath("config") .. "/lua"] = true,
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })

			-- configure rust_analyzer server
			local rt_status_ok, rt = pcall(require, "rust-tools")
			if not rt_status_ok then
				print("no rust-tools")
				return
			end

			local rust_opts = {
				tools = {
					autoSetHints = false,
					hover_actions = { border = false },
					cache = true,
				},
				server = {
					capabilities = capabilities,
					cmd = {
						"rustup",
						"run",
						"stable",
						"rust-analyzer",
					},
					settings = {
						["rust-analyzer"] = {
							diagnostics = {
								experimental = true,
							},
						},
					},
				},
			}
			rt.setup(rust_opts)
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
	{ "rafamadriz/friendly-snippets" },
}
