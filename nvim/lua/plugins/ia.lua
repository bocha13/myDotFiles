return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        -- everything is disabled to use nvim-cmp
        disable_inline_completion = true,
        disable_keymaps = true,
      })
    end,
  },
}
