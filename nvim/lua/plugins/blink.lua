return {
  {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/LuaSnip', 'rafamadriz/friendly-snippets' },
    version = '1.*',
    config = function(_, opts)
      -- Setup LuaSnip
      local luasnip = require("luasnip")
      local luaSnipLoader = require("luasnip.loaders.from_vscode")
      local blinkCmp = require("blink.cmp")
      luaSnipLoader.lazy_load()
      blinkCmp.setup(opts)

      luasnip.filetype_extend("javascriptreact", { "html" })
      luasnip.filetype_extend("typescriptreact", { "html" })
    end,
    opts = {
      keymap = { preset = 'enter' },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono'
      },
      completion = {
        documentation = { auto_show = true },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          -- nvim-cmp style menu
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label",     "label_description", gap = 1 },
              { "kind_icon", "kind" }
            },
          }
        },
      },
      sources = {
        default = { 'lsp', 'buffer', 'snippets', 'path' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  }
}
