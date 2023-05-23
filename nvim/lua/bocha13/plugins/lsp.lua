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

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<space>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

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

      -- configure astro lsp
      lspconfig["astro"].setup({
				capabilities = capabilities,
      })

			-- configure formatter
			lspconfig["eslint"].setup({
				capabilities = capabilities,
			})

			-- tailwind
			lspconfig["tailwindcss"].setup({
				capabilities = capabilities,
			})

			-- config yaml/docker servers
			lspconfig["yamlls"].setup({
				capabilities = capabilities,
			})

			-- configure lua server
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = {
					-- custom settings for lua
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
