local telescope_utils = require("utils").telescope_utils
local icons = require("utils").icons

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    version = false,
    keys = {
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
      { "<leader>ff", telescope_utils("files"),        desc = "Find Files (root dir)" },
      { "<leader>fg", telescope_utils(),               desc = "Find Files (repo)" },
      -- search
      { "<leader>sg", telescope_utils("live_grep"),    desc = "Grep (root dir)" },
      -- git
      -- { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    },
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        prompt_prefix = icons.common.arrow_right,
        selection_caret = icons.common.arrow_right,
        path_display = { "smart" },
        file_ignore_patterns = { "node_modules" },
        initial_mode = "insert",
        -- selection_strategy = "reset",
        sorting_strategy = "ascending",
        use_less = true,
        -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
      extensions = {
        file_browser = {
          hidden = false,
          respect_gitignore = false,
        },
      },
    },
  },
  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  --   keys = {
  --     {
  --       "<leader>e",
  --       ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  --       desc = "File Browser explorer",
  --     },
  --   },
  -- },
}
