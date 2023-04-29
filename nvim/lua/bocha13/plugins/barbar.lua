local function is_neotree_open()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "ft") == "neo-tree" then
      return require("bufferline.api").set_offset(35, "             Explorer")
    end
  end
  return require("bufferline.api").set_offset(0)
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWipeout" }, {
  pattern = "*",
  callback = function()
    is_neotree_open()
  end,
})

return {
  {
    "romgrk/barbar.nvim",
event = "BufWinEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
      keys = {
    { "<S-h>","<Cmd>BufferPrevious<CR>", desc = "Previous Buffer" },
    { "<S-l>","<Cmd>BufferNext<CR>", desc = "Next Buffer" },
    { "<A-c>","<Cmd>BufferClose<CR>", desc = "Close Buffer" },
    { "<A-p>","<Cmd>BufferPin<CR>", desc = "Pin Current Buffer" },
    { "<A-1>","<Cmd>BufferGoto 1<CR>", desc = "Go to buffer 1" },
    { "<A-2>","<Cmd>BufferGoto 2<CR>", desc = "Go to buffer 2" },
    { "<A-3>","<Cmd>BufferGoto 3<CR>", desc = "Go to buffer 3" },
    { "<A-4>","<Cmd>BufferGoto 4<CR>", desc = "Go to buffer 4" },
    { "<A-5>","<Cmd>BufferGoto 5<CR>", desc = "Go to buffer 5" },
    { "<A-6>","<Cmd>BufferGoto 6<CR>", desc = "Go to buffer 6" },
    { "<A-7>","<Cmd>BufferGoto 7<CR>", desc = "Go to buffer 7" },
    { "<A-8>","<Cmd>BufferGoto 8<CR>", desc = "Go to buffer 8" },
    { "<A-9>","<Cmd>BufferGoto 9<CR>", desc = "Go to buffer 9" },
    { "<A-0>","<Cmd>BufferGoto 0<CR>", desc = "Go to buffer 0" },
  },
opts = {
    -- Enable/disable animations
    animation = false,
    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,
    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,
    -- Enable/disable close button
    closable = true,
    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = true,
    -- Enables / disables diagnostic symbols
    -- Disable highlighting alternate buffers
    highlight_alternate = false,
    -- Disable highlighting file icons in inactive buffers
    highlight_inactive_file_icons = false,
    -- Enable highlighting visible buffers
    highlight_visible = true,
    -- Enable/disable icons
    -- if set to 'numbers', will show buffer index in the tabline
    -- if set to 'both', will show buffer index and icons in the tabline
    icons = {
      filetype = {
        enabled = true,
        custom_colors = false,
      },
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "E" }, -- ERROR
        [vim.diagnostic.severity.WARN] = { enabled = false },             -- WARN
        [vim.diagnostic.severity.INFO] = { enabled = false },             -- INFO
        [vim.diagnostic.severity.HINT] = { enabled = false },             -- HINT
      },
      button = "",
      modified = {
        button = "●",
      },
      pinned = {
        button = "車",
        filename = true,
        separator = { right = '' }
      },
      separator = {
        left = "▎",
        right = ""
      },
      inactive = {
        separator = {
          left = "▎",
        }
      }
    },
    -- If true, new buffers will be inserted at the start/end of the list.
    -- Default is to insert after current buffer.
    insert_at_end = false,
    insert_at_start = false,
    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,
    -- Sets the minimum padding width with which to surround each tab
    minimum_padding = 1,
    -- Sets the maximum buffer name length.
    maximum_length = 30,
    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = true,
    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustement
    -- for other layouts.
    letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,
  },
  }
  -- {
  --   'akinsho/bufferline.nvim',
  --   event = "VeryLazy",
  --   dependencies = 'nvim-tree/nvim-web-devicons',
  --   keys = {
  --     { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>",            desc = "Previous Buffer" },
  --     { "<S-l>", "<Cmd>BufferLineCycleNext<CR>",            desc = "Next Buffer" },
  --     { "<A-c>", "<Cmd>bdelete<CR>",                        desc = "Close Curent Buffer" },
  --     { "<A-p>", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
  --     { "<A-C>", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  --   },
  --   opts = {
  --     options = {
  --       mode = "buffers",
  --       close_command = "bdelete! %d",
  --       right_mouse_command = "bdelete! %d",
  --       left_mouse_command = "buffer %d",
  --       middle_mouse_command = "bdelete! %d",
  --       diagnostics = "nvim_lsp",
  --       always_show_bufferline = false,
  --       diagnostics_indicator = function(_, _, diag)
  --         local icons = {
  --           Error = " ",
  --           Warn = " ",
  --           Hint = " ",
  --           Info = " ",
  --         }
  --         local ret = (diag.error and icons.Error .. diag.error .. " " or "")
  --             .. (diag.warning and icons.Warn .. diag.warning or "")
  --         return vim.trim(ret)
  --       end,
  --       offsets = {
  --         {
  --           filetype = "neo-tree",
  --           text = "Explorer",
  --           highlight = "Directory",
  --           text_align = "center",
  --         },
  --       },
  --     },
  --   }
  -- }
}
