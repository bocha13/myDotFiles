vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    -- javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    -- html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    -- markdown = { "prettier" },
    graphql = { "prettier" },
  },
  format_on_save = {
    lsp_fallback = true,
  },
})
