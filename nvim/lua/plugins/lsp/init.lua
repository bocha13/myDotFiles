return {
  -- Provides command to tell gopls where the tinygo pachages are
  -- :TinyGoSetTarget rp2040
  {
    "pcolladosoto/tinygo.nvim",
    config = function() require("tinygo").setup() end
  }
}
