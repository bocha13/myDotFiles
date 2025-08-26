return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      local bufremove = require("mini.bufremove")
      local surround = require("mini.surround")
      local indentscope = require("mini.indentscope")
      local pairs = require("mini.pairs")
      local mini_tabline = require("mini.tabline")
      pairs.setup({})
      bufremove.setup({})
      mini_tabline.setup({
        show_icons = false,
        format = function(buf_id, label)
          -- if (vim.bo[buf_id].modified and buf_id == vim.api.nvim_get_current_buf()) then
          --   return "▌" .. MiniTabline.default_format(buf_id, label) .. "▐"
          -- if (vim.bo[buf_id].modified) then
          --   return " " .. MiniTabline.default_format(buf_id, label) .. " "
          -- elseif (buf_id == vim.api.nvim_get_current_buf()) then
          --   return "▌" .. MiniTabline.default_format(buf_id, label) .. "▐"
          -- end
          if (vim.bo[buf_id].modified) then
            return " " .. MiniTabline.default_format(buf_id, label) .. " "
          end

          return " " .. MiniTabline.default_format(buf_id, label) .. " "
        end,
        tabpage_section = 'left'
      })
      surround.setup({
        mappings = {
          add = "gza",            -- Add surrounding in Normal and Visual modes
          delete = "gzd",         -- Delete surrounding
          find = "gzf",           -- Find surrounding (to the right)
          find_left = "gzF",      -- Find surrounding (to the left)
          highlight = "gzh",      -- Highlight surrounding
          replace = "gzr",        -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`
        },
      })
      indentscope.setup({
        symbol = "│",
        options = { try_as_border = true },
      })

      -- CHANGE COLOURS OF TABLINE
      vim.api.nvim_set_hl(0, 'MiniTablineCurrent', {
        bg = "#292929",
        bold = true
      })
      vim.api.nvim_set_hl(0, 'MiniTablineHidden', {
        bg = "#141617",
        bold = true
      })

      vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', {
        fg = '#8fc28c',
        bold = true
      })
    end
  },
}
