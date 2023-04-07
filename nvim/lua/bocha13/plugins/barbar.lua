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
  "romgrk/barbar.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function() vim.g.barbar_auto_setup = false end,
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
