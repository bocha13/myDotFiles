vim.pack.add({ "https://github.com/saghen/blink.cmp" })

-- rebuild blink fuzzy matcher whenever we update blink plugin
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "blink.cmp" and ev.data.kind == "update" then
      local dir = ev.data.path
      vim.notify("blink.cmp: building fuzzy library...", vim.log.levels.INFO)
      vim.system(
        { "cargo", "build", "--release" },
        { cwd = dir },
        function(result)
          if result.code == 0 then
            vim.schedule(function()
              vim.notify("blink.cmp: build succeeded", vim.log.levels.INFO)
            end)
          else
            vim.schedule(function()
              vim.notify("blink.cmp: build failed\n" .. (result.stderr or ""), vim.log.levels.ERROR)
            end)
          end
        end
      )
    end
  end,
})

local luasnip = require("luasnip")
local luaSnipLoader = require("luasnip.loaders.from_vscode")
local blinkCmp = require("blink.cmp")

luaSnipLoader.lazy_load()

blinkCmp.setup({
  keymap = { preset = 'enter' },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono'
  },
  completion = {
    documentation = { auto_show = true },
    list = { selection = { preselect = false, auto_insert = true } },
    menu = {
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
  fuzzy = { implementation = "prefer_rust" }
})

luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("typescriptreact", { "html" })
