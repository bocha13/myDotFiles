return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "CodeCompanionChat",
    config = function()
      require('codecompanion').setup({
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = ""
            }
          })
        end
      })
    end

  },
}
