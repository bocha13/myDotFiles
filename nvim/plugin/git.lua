vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/akinsho/git-conflict.nvim"
})
require("gitsigns").setup({
  signs = {
    add = { text = "█" },
    change = { text = "█" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "█" },
    untracked = { text = "█" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = "none",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns
    local bufopts = { noremap = true, silent = true, buffer = buffer }
    vim.keymap.set("n", "<leader>gf", gs.preview_hunk, bufopts)
    vim.keymap.set("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, bufopts)
  end,
})

-- vim-fugitive
vim.keymap.set("n", "<leader>gv", ":Gdiffsplit!<CR>", { desc = "Open Git diff" })
vim.keymap.set("n", "<leader>gV", "<c-w>h<c-w>c<CR>", { desc = "Close fugitive buffer" })

-- git-conflict
require("git-conflict").setup()
