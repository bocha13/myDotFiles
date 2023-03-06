return {
	-- LSP support
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs = { Error = "E", Warn = "W", Hint = "H", Info = "E" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- configure ts and js servers
			lspconfig["tsserver"].setup({
				capabilities = capabilities,
			})

			-- config yaml/docker servers
			lspconfig["yamlls"].setup({
				capabilities = capabilities,
			})

			-- configure lua server
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = { -- custom settings for lua
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							-- make language server aware of runtime files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})

			-- configure prisma server
			lspconfig["prismals"].setup({
				capabilities = capabilities,
			})

			-- configure rust server
			lspconfig["rust_analyzer"].setup({
				capabilities = capabilities,
				cmd = {
					"rustup",
					"run",
					"stable",
					"rust-analyzer",
				},
			})

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
							checkOnSave = {
								command = "clippy",
							},
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
}
