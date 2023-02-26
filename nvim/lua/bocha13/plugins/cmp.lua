return {
	{ "onsails/lspkind.nvim" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_cehck_events = "TextChanged",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			local source_mapping = {
				buffer = "[Buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				cmp_tabnine = "[TN]",
				path = "[Path]",
			}

			return {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
						vim_item.menu = source_mapping[entry.source.name]
						if entry.source.name == "cmp_tabnine" then
							local detail = (entry.completion_item.data or {}).detail
							vim_item.kind = ""
							if detail and detail:find(".*%%.*") then
								vim_item.kind = vim_item.kind .. " " .. detail
							end

							if (entry.completion_item.data or {}).multiline then
								vim_item.kind = vim_item.kind .. " " .. "[ML]"
							end
						end
						local maxwidth = 80
						vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
						return vim_item
					end,
				},
				sources = {
					{ name = "cmp_tabnine", group_index = 2 },
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
				-- window = {
				-- 	documentation = {
				-- 		winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
				-- 		border = "rounded",
				-- 	},
				-- 	completion = {
				-- 		winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
				-- 		border = "rounded",
				-- 	},
				-- },
			}
		end,
	},
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		config = function()
			local tabnine = require("cmp_tabnine.config")
			tabnine:setup({
				snippet_placeholder = "..",
				sort = true,
			})
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lua" },
}
