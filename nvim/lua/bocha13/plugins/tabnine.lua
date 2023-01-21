local cmp = require("cmp")
cmp.setup {
  sources = {
    { name = "buffer" },
    { name = "nvim_lsp" },
    { name = "cmp_tabnine" },
  }
}

return {
  "tzachar/cmp-tabnine",
  dependencies = "hrsh7th/nvim-cmp",
  -- manually run this command from
  -- {user}/.local/share/nvim/lazy/cmp-tabnine/install.sh
  build = "./install.sh",
  config = function()
    require("cmp_tabnine.config").setup({
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      ignored_file_types = {
        -- lua = false
      },
      show_prediction_strength = true,
    })
  end
}
