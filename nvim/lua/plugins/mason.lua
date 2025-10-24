return {
  "mason-org/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    ui = {
      icons = {
        package_installed = "󰸞",
        package_pending = "󰜴",
        package_uninstalled = "",
      }
    }
  }
}
