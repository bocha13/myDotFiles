return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- set keymaps
		local keymap = vim.keymap
		local on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }

			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			keymap.set("n", "gr", vim.lsp.buf.references, opts)
			keymap.set("n", "K", vim.lsp.buf.hover, opts)
			keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			keymap.set("n", "<space>cd", vim.diagnostic.open_float, opts)

			-- diable formatting for tsserver so eslint handles it
			if client.name == "tsserver" then
				client.server_capabilities.documentFormattingProvider = false
			else
				client.server_capabilities.documentFormattingProvider = true
			end
		end

		-- used to enable autocompletion
		local capabilities = cmp_nvim_lsp.default_capabilities()
		local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- default config for all servers
		local defaultOpts = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- add servers to this list and they will be automatically setup
		local serverList = {
			["html"] = defaultOpts,
			["cssls"] = defaultOpts,
			["graphql"] = defaultOpts,
			["tsserver"] = defaultOpts,
			["tailwindcss"] = defaultOpts,
			["gopls"] = defaultOpts,
			["prismals"] = defaultOpts,
			["rust_analyzer"] = {
				capabilities = capabilities,
				on_attach = on_attach,
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					runBuildScripts = true,
				},
				-- Add clippy lints for Rust.
				checkOnSave = {
					allFeatures = true,
					command = "clippy",
					extraArgs = { "--no-deps" },
				},
				procMacro = {
					enable = true,
					ignored = {
						leptos_macro = {
							-- "component",
							"server",
						},
						async_trait = { "async_trait" },
						napi_derive = { "napi" },
						async_recursion = { "async_recursion" },
					},
				},
			},
			["eslint"] = defaultOpts,
			["jsonls"] = defaultOpts,
			["lua_ls"] = {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "general" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},
		}

		for server, config in pairs(serverList) do
			lspconfig[server].setup(config)
		end
	end,
}
