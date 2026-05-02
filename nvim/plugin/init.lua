vim.pack.add({
  -- UI
  { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
  -- File navigation
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  -- Utilities
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
})
-- vim-tmux-navigator keymaps
vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")

-- nvim-ts-autotag
require("nvim-ts-autotag").setup({})

-- nvim-highlight-colors
require("nvim-highlight-colors").setup({})
