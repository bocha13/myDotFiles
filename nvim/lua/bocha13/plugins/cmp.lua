return {
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
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
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			return {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "copilot", group_index = 1 },
					{ name = "buffer", group_index = 1 },
					{ name = "nvim_lsp", group_index = 1 },
					{ name = "path", group_index = 1 },
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
			}
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			sugestion = { enabled = false },
			panel = { enabled = false },
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua" },
		event = "BufReadPre",
		config = function(_, opts)
			local copilot_cmp = require("copilot_cmp")
			copilot_cmp.setup(opts)
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
	{ "hrsh7th/cmp-buffer", event = "VeryLazy" },
	{
		"hrsh7th/cmp-path",
		event = "VeryLazy",
	},
	{
		"hrsh7th/cmp-nvim-lua",
		event = "VeryLazy",
	},
}
