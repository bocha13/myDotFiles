return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
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
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  -- {
  --   "oxfist/night-owl.nvim",
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd.colorscheme("night-owl")
  --   end,
  -- }
  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.g.gruvbox_material_foreground = "mix"
  --     vim.cmd.colorscheme("gruvbox-material")
  --   end
  -- }
}
