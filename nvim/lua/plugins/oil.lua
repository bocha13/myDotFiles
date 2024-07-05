return {
  "stevearc/oil.nvim",
  opts = {},
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
      },
    })

    vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
