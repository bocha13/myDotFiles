return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>e",
      "<cmd>Neotree toggle<CR>",
      desc = "Explorer NeoTree (root dir)",
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_diagnostics = true,
      default_component_configs = {
        indent = {
          padding = 0,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
        git_status = {
          symbols = {
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        width = 35,
        mappings = {
          ["o"] = "open",
          ["v"] = "open_vsplit",
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true
        },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_)
            vim.opt_local.signcolumn = "auto"
          end,
        },
      },
    })
  end,
}
