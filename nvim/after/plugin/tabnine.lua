local status_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not status_ok then
	return
end

local cmp = require("cmp")
cmp.setup {
  sources = {
    {name = "buffer"},
    {name = "nvim_lsp"},
    {name = "cmp_tabnine"}
  }
}

tabnine.setup({
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
