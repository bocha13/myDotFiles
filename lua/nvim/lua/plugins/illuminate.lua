-- local u = require("config.utils")

-- local illuminate = require("illuminate")

-- u.nmap("<M-n>", function()
-- illuminate.next_reference({ wrap = true })
-- end)
-- u.nmap("<M-p>", function()
-- illuminate.next_reference({ reverse = true, wrap = true })
-- end)

-- vim.g.Illuminate_delay = 0
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree", "DressingSelect", "harpoon" }
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.api.nvim_set_keymap("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<a-p>",
	'<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
	{ noremap = true }
)
