return {
  -- Provides command to tell gopls where the tinygo packages are
  -- :TinyGoSetTarget rp2040
  {
    "pcolladosoto/tinygo.nvim",
    cmd = { "TinyGoSetTarget", "TinyGoEnv", "TinyGoTargets" },
    config = function() require("tinygo").setup() end
  }
}
