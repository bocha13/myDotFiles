local fg = require("utils").fg
local icons = require("utils").icons

return {
  "nvim-lualine/lualine.nvim",
  -- event = "VeryLazy",
  opts = function()
    return {
      options = {
        icons_enabled = true,
        theme = "auto",
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "lazy" } },
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
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = fg("Special"),
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
          -- {
          --   'vim.fn["codeium#GetStatusString"]()',
          --   fmt = function(str)
          --     if str == " ON" then
          --       return "{..}"
          --     elseif str == " OFF" then
          --       return "{..}"
          --     elseif str == " * " then
          --       return ".."
          --     else
          --       return str
          --     end
          --   end,
          -- },
          { "progress", padding = { left = 1, right = 1 } },
          -- function()
          -- 	return icons.common.time .. os.date("%R")
          -- end,
        },
        lualine_z = {
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    }
  end,
}
