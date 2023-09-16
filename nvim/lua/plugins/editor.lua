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
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { "DiffviewOpen", "DiffviewClose" },
    keys = {
      { "<leader>gd", ":DiffviewOpen<CR>",  desc = "Open Diffview" },
      { "<leader>gD", ":DiffviewClose<CR>", desc = "Close Diffview" },
    }
  }
}
