return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",                                    --source for text in buffers
      "hrsh7th/cmp-path",                                      -- source for file system paths
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- snippet engine
      "saadparwaiz1/cmp_luasnip",                              -- for autocompletion
      "rafamadriz/friendly-snippets",                          -- useful snippets
      -- "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- local lspkind = require("lspkind")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      -- load vs-code like snippets from plugins
      require("luasnip.loaders.from_vscode").lazy_load()

      vim.opt.completeopt = "menu,preview,menuone,noinsert"
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- formatting = {
        --   format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
        -- },
        mapping = cmp.mapping.preset.insert({
          ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
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
        -- sources for autocompletion
        sources = cmp.config.sources({
          -- { name = "codeium" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = require("nvim-highlight-colors").format
        },
      })
    end,
  },
}
