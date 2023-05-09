return {
  {
    'folke/tokyonight.nvim',
    config = function()
      require("tokyonight").setup({
        style = "night",
        on_colors = function(c)
          c.gitSigns = {
            add = "#8fc28c",
            change = "#7495d1",
            delete = "#f38ba8",
          }
        end,
        		on_highlights = function(highlight, c)
  		-- mini.indent line color
  		-- highlight.MiniIndentscopeSymbol = {
  		-- 	fg = c.border,
  		-- }
  		-- 	highlight.BufferTabpageFill = {
  		-- 		bg = c.bg_statusline,
  		-- 		fg = "#3b4261",
  		-- 	}
  		-- 	highlight.BufferOffset = {
  		-- 		bg = c.bg_statusline,
  		-- 		fg = "#65bcff",
  		-- 	}
  		-- 	highlight.BufferInactiveSign = {
  		-- 		bg = "#161824",
  		-- 		fg = "#65bcff",
  		-- 	}
  		-- 	highlight.BufferCurrentSign = {
  		-- 		bg = "#3b4261",
  		-- 		fg = "#65bcff",
  		-- 	}
  		-- 	highlight.MsgArea = {
  		-- 		bg = c.bg,
  		-- 		fg = "#65bcff",
  		-- 	}
  	end,
      })
      vim.cmd.colorscheme("tokyonight")
    end
  }
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = function()
  --     require("rose-pine").setup({
  --       highlight_groups = {
  --         GitSignsAdd = { fg = "#8fc28c" },
  --         GitSignsChange = { fg = "#7495d1" },
  --         GitSignsDelete = { fg = "#f38ba8" },
  --         -- IlluminatedWordText = { bg = "#282838" },
  --         -- IlluminatedWordRead = { bg = "#45475a" },
  --         -- IlluminatedWordWrite = { bg = "#45475a" },
  --         MiniIndentscopePrefix = {
  --           nocombine = true
  --         },
  --         MiniIndentscopeSymbol = {
  --           fg = "#d6d5eb"
  --         },
  --         BufferOffset = { fg = "#d6d5eb", bg = "#1f1d2e" },
  --         BufferTabpageFill = {
  --           bg = "#1f1d2e",
  --           fg = "#737aa2"
  --         },
  --         BufferTabpages = {
  --           bg = "1f1d2e",
  --           fg = "NONE"
  --         },
  --       }
  --     })
  --     vim.cmd.colorscheme("rose-pine")
  --   end
  -- },
}
