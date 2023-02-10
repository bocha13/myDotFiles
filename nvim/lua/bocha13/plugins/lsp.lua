return {
	-- LSP support
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Change the Diagnostic symbols in the sign column (gutter)
			-- (not in youtube nvim video)
			local signs = { Error = "E", Warn = "W", Hint = "H", Info = "E" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- configure tsserver
			lspconfig["tsserver"].setup({
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
			lspconfig["sumneko_lua"].setup({
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
		"williamboman/mason.nvim",
		config = function()
			local mason = require("mason")
			local mason_lsp = require("mason-lspconfig")
			local mason_null_ls = require("mason-null-ls")

			local config = {
				virtual_text = true,
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

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "copilot", group_index = 2 },
					{ name = "luasnip", group_index = 3 },
					{ name = "buffer", group_index = 2 },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "path", group_index = 2 },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				}),
				window = {
					documentation = {
						border = "rounded",
						winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
					},
					completion = {
						border = "rounded",
						winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
					},
				},
			})
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lua" },

	-- Snippets
	{ "L3MON4D3/LuaSnip" }, -- Required
	{ "rafamadriz/friendly-snippets" }, -- Optional
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					formatting.prettier,
					formatting.stylua,
					diagnostics.eslint_d.with({
						-- only enable islint if root has .eslintrc.js
						confition = function(utils)
							return utils.root_has_file(".eslintrc.js")
						end,
					}),
				},
				-- configure format on save
				on_attach = function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									filter = function(client)
										--  only use null-ls for formatting instead of lsp server
										return client.name == "null-ls"
									end,
									bufnr = bufnr,
								})
							end,
						})
					end
				end,
			})
		end,
	},
}
