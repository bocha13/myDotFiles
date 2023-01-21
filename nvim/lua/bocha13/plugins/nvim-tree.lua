return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 37
      },
      diagnostics = {
        enable = true
      },
      update_focused_file = { enable = true }
    })
  end
}
