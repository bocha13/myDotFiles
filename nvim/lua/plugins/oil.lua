return {
  "stevearc/oil.nvim",
  opts = {},
  keys = {
    {
      "<leader>e",
      function()
        local oil = require("oil")
        oil.open()
      end,
      desc = "Open parent directory"
    }
  },
  config = function()
    local oil = require("oil")
    oil.setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
      },
    })
  end
}
