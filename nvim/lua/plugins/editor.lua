return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
    config = true,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-web-devicons" },
    event = "VeryLazy",
  },
  {
    "sindrets/diffview.nvim",
    -- event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose" },
    keys = {
      { "<leader>gd", ":DiffviewOpen<CR>",  desc = "Open Diffview" },
      { "<leader>gD", ":DiffviewClose<CR>", desc = "Close Diffview" },
    },
  },
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   init = function()
  --     vim.o.timeout = true
  --     vim.o.timeoutlen = 300
  --   end,
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   }
  -- },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
  }
}
