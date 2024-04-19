return {
  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>",            desc = "Previous Buffer" },
      { "<S-l>", "<Cmd>BufferLineCycleNext<CR>",            desc = "Next Buffer" },
      { "<A-p>", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<A-C>", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        -- mode = "buffers",
        indicator_icon = " ",
        show_close_icon = false,
        buffer_close_icon = "",
        close_icon = "",
        -- show_buffer_icons = false,
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        middle_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        -- diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = {
        --     Error = "E",
        --     Warn = "W",
        --     Hint = "H",
        --     Info = "I",
        --   }
        --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        --       .. (diag.warning and icons.Warn .. diag.warning or "")
        --   return vim.trim(ret)
        -- end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Explorer",
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    },
  },
}
