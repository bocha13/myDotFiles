return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanionChat", "CodeCompanionActions" },
    config = function()
      local api_key = os.getenv("CODECOMPANION_API_KEY")
      require('codecompanion').setup({
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = api_key
            }
          })
        end
      })
    end

  },
}
