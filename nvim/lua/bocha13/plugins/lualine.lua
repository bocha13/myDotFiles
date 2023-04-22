return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local icons = {
      diagnostics = {
        Error = "E ",
        Warn = "W ",
        Hint = "H ",
        Info = "I ",
      },
      git = {
        added = " ",
        modified = " ",
        removed = " ",
      },
    }
    local function fg(name)
      return function()
        local hl = vim.api.nvim_get_hl_by_name(name, true)
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
      end
    end

    -- changed the background color of the statusline to match the theme rose-pine
    local rose_pine_background = require("lualine.themes.auto")
    rose_pine_background.normal.c.bg = "#26233a"
    rose_pine_background.insert.c.bg = "#26233a"
    rose_pine_background.visual.c.bg = "#26233a"
    rose_pine_background.command.c.bg = "#26233a"
    rose_pine_background.replace.c.bg = "#26233a"

    return {
      options = {
        theme = rose_pine_background,
        globalstatus = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "lazy" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          -- show filename, type, icon and path in statusline
          -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          -- {
          -- 	function()
          -- 		return require("nvim-navic").get_location()
          -- 	end,
          -- 	cond = function()
          -- 		return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          -- 	end,
          -- },
        },
        lualine_x = {
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
          { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
    }
  end,
}
