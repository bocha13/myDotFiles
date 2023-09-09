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
}
