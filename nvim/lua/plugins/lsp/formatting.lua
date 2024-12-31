return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
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
    end,
  },
}
