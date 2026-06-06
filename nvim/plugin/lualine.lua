vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local icons = require("utils").icons

local function build_theme(p)
  return {
    normal = {
      a = { bg = p.blue, fg = p.base, gui = "bold" },
      b = { bg = p.surface0, fg = p.text },
      c = { bg = p.mantle, fg = p.text },
    },
    insert = {
      a = { bg = p.green, fg = p.base, gui = "bold" },
      b = { bg = p.surface0, fg = p.text },
      c = { bg = p.mantle, fg = p.text },
    },
    visual = {
      a = { bg = p.mauve, fg = p.base, gui = "bold" },
      b = { bg = p.surface0, fg = p.text },
      c = { bg = p.mantle, fg = p.text },
    },
    replace = {
      a = { bg = p.red, fg = p.base, gui = "bold" },
      b = { bg = p.surface0, fg = p.text },
      c = { bg = p.mantle, fg = p.text },
    },
    command = {
      a = { bg = p.peach, fg = p.base, gui = "bold" },
      b = { bg = p.surface0, fg = p.text },
      c = { bg = p.mantle, fg = p.text },
    },
    inactive = {
      a = { bg = p.mantle, fg = p.overlay1 },
      b = { bg = p.mantle, fg = p.overlay1 },
      c = { bg = p.mantle, fg = p.overlay1 },
    },
  }
end

local function build_config(theme)
  return {
    options = {
      icons_enabled = true,
      theme = theme,
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
  }
end

function _G.LualineApplyPalette(p)
  require("lualine").setup(build_config(build_theme(p)))
end

-- Initial setup with a dark fallback palette; mini.lua re-applies with the
-- active variant's palette right after it runs apply_theme.
local fallback = {
  base     = "#1d2021",
  mantle   = "#191b1c",
  surface0 = "#292929",
  overlay1 = "#928374",
  text     = "#ebdbb2",
  red      = "#ea6962",
  peach    = "#e78a4e",
  green    = "#a9b665",
  blue     = "#7daea3",
  mauve    = "#d3869b",
}
require("lualine").setup(build_config(build_theme(fallback)))
