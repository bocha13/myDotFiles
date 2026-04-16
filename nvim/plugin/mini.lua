vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local bufremove = require("mini.bufremove")
local surround = require("mini.surround")
local indentscope = require("mini.indentscope")
local pairs = require("mini.pairs")
local tabline = require("mini.tabline")

pairs.setup({})
bufremove.setup({})
tabline.setup({
  show_icons = false,
  format = function(buf_id, label)
    if (vim.bo[buf_id].modified) then
      return " " .. tabline.default_format(buf_id, label) .. " "
    end
    return " " .. tabline.default_format(buf_id, label) .. " "
  end,
  tabpage_section = 'left'
})
surround.setup({
  mappings = {
    add = "gza",
    delete = "gzd",
    find = "gzf",
    find_left = "gzF",
    highlight = "gzh",
    replace = "gzr",
    update_n_lines = "gzn",
  },
})
indentscope.setup({
  symbol = "│",
  options = { try_as_border = true },
})

vim.api.nvim_set_hl(0, 'MiniTablineCurrent', {
  fg = "#ebdbb2",
  bg = "#404040",
  bold = true
})
vim.api.nvim_set_hl(0, 'MiniTablineHidden', {
  fg = "#a89984",
  bg = "#141617",
  bold = true
})
