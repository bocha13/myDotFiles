vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local icons = require("utils").icons

local colors = {
  red = "#ea6962",
  pink = "#d3869b",
  peach = "#e78a4e",
  yellow = "#d8a657",
  green = "#a9b665",
  teal = "#89b482",
  blue = "#7daea3",
  text = "#ebdbb2",
  subtext1 = "#d5c4a1",
  overlay1 = "#928374",
  surface2 = "#4d4d4d",
  surface1 = "#404040",
  surface0 = "#292929",
  base = "#1d2021",
  mantle = "#191b1c",
  crust = "#141617",
}

local custom_theme = {
  normal = {
    a = { bg = colors.blue, fg = colors.base, gui = "bold" },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.mantle, fg = colors.text },
  },
  insert = {
    a = { bg = colors.green, fg = colors.base, gui = "bold" },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.mantle, fg = colors.text },
  },
  visual = {
    a = { bg = colors.pink, fg = colors.base, gui = "bold" },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.mantle, fg = colors.text },
  },
  replace = {
    a = { bg = colors.red, fg = colors.base, gui = "bold" },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.mantle, fg = colors.text },
  },
  command = {
    a = { bg = colors.peach, fg = colors.base, gui = "bold" },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.mantle, fg = colors.text },
  },
  inactive = {
    a = { bg = colors.mantle, fg = colors.overlay1 },
    b = { bg = colors.mantle, fg = colors.overlay1 },
    c = { bg = colors.mantle, fg = colors.overlay1 },
  },
}

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = custom_theme,
    globalstatus = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = { "dashboard" } },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "filename",
        path = 0,
        symbols = {
          modified = icons.symbols.modified,
          readonly = icons.symbols.readonly,
          unnamed = icons.symbols.unnamed,
          newfile = icons.symbols.newfile
        },
      },
    },
    lualine_x = {
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
      },
    },
    lualine_y = {
      { "progress", padding = { left = 1, right = 1 } },
    },
    lualine_z = {
      { "location", padding = { left = 0, right = 1 } },
    },
  },
})
