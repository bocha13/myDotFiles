return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
    config = true
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-web-devicons" },
    event = "VeryLazy"
  },
  {
    'sindrets/diffview.nvim',
    -- event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose" },
    keys = {
      { "<leader>gd", ":DiffviewOpen<CR>",  desc = "Open Diffview" },
      { "<leader>gD", ":DiffviewClose<CR>", desc = "Close Diffview" },
    }
  }
}
