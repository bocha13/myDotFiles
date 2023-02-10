return {
    -- lspconfig
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
        config = function()
          local lsp = require("lsp-zero")
          local cmp = require("cmp")
          local luasnip = require("luasnip")

          cmp.setup {
              snippet = {
                  expand = function(args)
                    luasnip.lsp_expand(args.body)
                  end
              },
              sources = {
                  { name = "copilot",  group_index = 2 },
                  { name = "luasnip",  group_index = 3 },
                  { name = "buffer",   group_index = 2 },
                  { name = "nvim_lsp", group_index = 2 },
                  { name = "path",     group_index = 2 },
              }
          }
          vim.diagnostic.config({
              underline = true,
              update_in_insert = true,
              virtual_text = { spacing = 4, prefix = "●" },
              severity_sort = true
          })

          local cmp_select   = { behavior = cmp.SelectBehavior.Select }
          local cmp_mappings = lsp.defaults.cmp_mappings({
                  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                  ['<C-Space>'] = cmp.mapping.complete(),
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
              })

          lsp.preset("recommended")
          lsp.ensure_installed({
              "tsserver",
              "eslint",
              "sumneko_lua",
              "rust_analyzer"
          })
          lsp.set_preferences({
              sign_icons = {
                  error = "E",
                  warn = "W",
                  hint = "H",
                  info = "I"
              }
          })
          lsp.setup_nvim_cmp({
              completion = {
                  completeopt = "menu,menuone,noinsert,noselect"
              },
              mapping = cmp_mappings,
              confirm_opts = {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
              },
          })

          lsp.setup()
        end
    },
}
