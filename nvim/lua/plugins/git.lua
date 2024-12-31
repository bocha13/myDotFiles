return {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
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
        add = { text = "█" },
        change = {
          text = "█",
        },
        delete = {
          text = "",
        },
        topdelete = {
          text = "",
        },
        changedelete = {
          text = "█",
        },
        untracked = { text = "█" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "none",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns
      local bufopts = { noremap = true, silent = true, buffer = buffer }
      vim.keymap.set("n", "<leader>gp", gs.preview_hunk, bufopts)
      vim.keymap.set("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, bufopts)
    end,
  },
  {
    "tpope/vim-fugitive",
    event = "BufWinEnter",
    config = function()
      vim.keymap.set("n", "<leader>gv", ":Gdiffsplit!<CR>", { desc = "Open Git diff" })
      vim.keymap.set("n", "<leader>gV", "<c-w>h<c-w>c<CR>", { desc = "Close fugitive buffer" })
    end
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      vim.cmd([[highlight NewIncoming guibg=#344f69]])
      vim.cmd([[highlight NewCurrent guibg=#2e5049]])
      require("git-conflict").setup({
        highlights = {
          incoming = "NewIncoming",
          current = "NewCurrent",
        },
      })
    end,
  },
}
