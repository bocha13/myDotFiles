return {
  {
    "numToStr/Comment.nvim",
    keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
    config = true
  },
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
      { "<leader>gc", ":Git commit -m \"",            desc = "Git commit with message" },
      { "<leader>gp", ":Git push -u origin HEAD<CR>", desc = "Git push to origin" },
      { "<leader>gs", ":Git<CR>",                     desc = "Open fugitive panel" },
    }
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-web-devicons" },
    event = "VeryLazy"
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter"
  }
}
