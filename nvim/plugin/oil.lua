vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
  },
})

vim.keymap.set("n", "<leader>e", function()
  require("oil").open()
end, { desc = "Open parent directory" })
