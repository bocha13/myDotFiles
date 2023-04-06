return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        highlight_groups = {
          GitSignsAdd = { fg = "#8fc28c" },
          GitSignsChange = { fg = "#7495d1" },
          GitSignsDelete = { fg = "#f38ba8" },
          StatusLine = { bg = "#1f1d2e" },
          MiniIndentscopePrefix = {
            nocombine = true
          },
          MiniIndentscopeSymbol = {
            fg = "#d6d5eb"
          },
        }
      })
      vim.cmd.colorscheme("rose-pine")
    end
  },
  -- {
  -- 	"catppuccin/nvim",
  -- 	name = "catppuccin",
  -- 	config = function()
  -- 		require("catppuccin").setup({
  -- 			integrations = {
  -- 				barbar = true,
  -- 				telescope = true,
  -- 				cmp = true,
  -- 				gitsigns = true,
  -- 				neotree = true,
  -- 			},
  -- 			color_overrides = {
  -- 				flavour = "mocha",
  -- 				mocha = {
  -- 					base = "#191724",
  -- 					mantle = "#2b2b3c",
  -- 					crust = "#2b2b3c",
  -- 				},
  -- 			},
  -- 			highlight_overrides = {
  -- 				mocha = {
  -- 					NeoTreeNormal = { bg = "#191724" },
  -- 					NeoTreeNormalNC = { bg = "#191724" },
  -- 					TelescopeBorder = { fg = "#c8aaad" },
  -- 					BufferCurrentERROR = { fg = "#f38ba8", bg = "#45475a" },
  -- 					GitSignsAdd = { fg = "#8fc28c" },
  -- 					GitSignsChange = { fg = "#7495d1" },
  -- 					GitSignsDelete = { fg = "#f38ba8" },
  -- 					IlluminatedWordText = { bg = "#282838" },
  -- 					IlluminatedWordRead = { bg = "#45475a" },
  -- 					IlluminatedWordWrite = { bg = "#45475a" },
  -- 				},
  -- 			},
  -- 		})
  -- 		vim.cmd.colorscheme("catppuccin")
  -- 	end,
  -- },
}
