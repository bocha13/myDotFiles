return {
  "stevearc/oil.nvim",
  opts = {},
  keys = {
    {
      "<leader>e",
      function()
        require("oil").open()
      end,
      desc = "Open parent directory"
    }
  },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
      },
    })
  end
}
