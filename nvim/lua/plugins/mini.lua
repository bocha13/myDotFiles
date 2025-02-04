return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      local bufremove = require("mini.bufremove")
      local surround = require("mini.surround")
      local indentscope = require("mini.indentscope")
      local pairs = require("mini.pairs")
      pairs.setup({})
      bufremove.setup({})
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

      vim.api.nvim_set_keymap('n', '<leader>bd', ":lua require'mini.bufremove'.delete(0)<CR>",
        { noremap = true, silent = true })
    end
  },
}
