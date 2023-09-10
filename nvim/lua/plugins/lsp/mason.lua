return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim"
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "tsserver",
        "lua_ls",
        "html",
        "cssls",
        "gopls",
        "tailwindcss",
        "graphql",
        "eslint"
      },
      automatic_installation = true
    })
  end
}
