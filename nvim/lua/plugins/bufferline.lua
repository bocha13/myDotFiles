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
        indicator_icon = " ",
        show_close_icon = false,
        buffer_close_icon = "",
        close_icon = "",
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        middle_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        always_show_bufferline = false,
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
