return {
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
      { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>",            desc = "Previous Buffer" },
      { "<S-l>", "<Cmd>BufferLineCycleNext<CR>",            desc = "Next Buffer" },
      { "<A-c>", "<Cmd>bdelete<CR>",                        desc = "Close Curent Buffer" },
      { "<A-p>", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<A-C>", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        mode = "buffers",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diag)
          local icons = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " ",
          }
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Explorer",
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    }
  }
}
