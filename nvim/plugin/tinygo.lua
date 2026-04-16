vim.pack.add({ "https://github.com/pcolladosoto/tinygo.nvim" })

-- Provides command to tell gopls where the tinygo packages are
-- :TinyGoSetTarget rp2040
require("tinygo").setup({})
