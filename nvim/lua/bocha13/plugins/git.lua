return {
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
      { "<leader>gc", ":Git commit -m \"", desc = "Git commit with message" },
      { "<leader>gp", ":Git push -u origin HEAD<CR>", desc = "Git push to origin" },
      { "<leader>gs", ":Git<CR>", desc = "Open fugitive panel" },
    }
  }
}
