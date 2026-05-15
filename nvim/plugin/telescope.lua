vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" })

local telescope_utils = require("utils").telescope_utils
local icons = require("utils").icons

require("telescope").setup({
  defaults = {
    layout_config = { prompt_position = "top" },
    prompt_prefix = icons.common.arrow_right,
    selection_caret = icons.common.arrow_right,
    path_display = { "smart" },
    file_ignore_patterns = { "node_modules" },
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    use_less = true,
    preview = {
      treesitter = false,
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob=!node_modules/*',
      '--glob=!dist/*',
      '--glob=!src/generated/*',
    },
  },
  extensions = {
    file_browser = {
      hidden = false,
      respect_gitignore = false,
    },
  },
})

-- keymaps
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>ff", telescope_utils("find_files"), { desc = "Find Files (root dir)" })
vim.keymap.set("n", "<leader>fg", telescope_utils("git_files"), { desc = "Find Files (repo)" })
vim.keymap.set("n", "<leader>sg", telescope_utils("live_grep"), { desc = "Grep (root dir)" })
vim.keymap.set("n", "<leader>gs", telescope_utils("git_status"), { desc = "Git status in a fuzzy searcher" })
vim.keymap.set("n", "<leader>gc", telescope_utils("git_commits"), { desc = "Git log" })
