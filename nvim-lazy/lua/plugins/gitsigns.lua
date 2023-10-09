return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>gf",
        "<cmd>Gitsigns preview_hunk<CR>",
        desc = "Preview git diff of current line",
      },
      {
        "<leader>gb",
        "<cmd>Gitsigns blame_line<CR>",
        desc = "Preview git blame for current line",
      },
    },
    opts = {
      signs = {
        add = { hl = "GitSignsAdd", text = "█", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = {
          hl = "GitSignsChange",
          text = "█",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = "~",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "~",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "█",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        untracked = { text = "█" },
      },
    },
  },
}
