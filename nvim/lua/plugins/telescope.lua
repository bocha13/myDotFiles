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
      { "<leader>fb", "<cmd>Telescope buffers<cr>",   desc = "Buffers" },
      { "<leader>ff", telescope_utils("find_files"),  desc = "Find Files (root dir)" },
      { "<leader>fg", telescope_utils("git_files"),   desc = "Find Files (repo)" },
      -- search
      { "<leader>sg", telescope_utils("live_grep"),   desc = "Grep (root dir)" },
      -- git
      { "<leader>gs", telescope_utils("git_status"),  desc = "Git status in a fuzzy searcher" },
      { "<leader>gc", telescope_utils("git_commits"), desc = "Git log" },
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
}
