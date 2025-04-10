return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanionChat", "CodeCompanionActions" },
    config = function()
      require('codecompanion').setup({
        strategies = {
          chat = {
            adapter = "anthropic"
          },
          inline = {
            adapter = "anthropic"
          }
        },
        adapters = {
          anthropic = function()
            local api_key = os.getenv("ANTHROPIC_API_KEY")
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = api_key
              }
            })
          end
        }
      })
    end

  },
}
