local map = vim.keymap.set
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- Move Lines
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

map("n", "<C-d", "<C-d>zz")
map("n", "<C-u", "<C-u>zz")

-- paste but don't save to buffer
map("x", "<leader>p", '"_dp')

-- use system clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+y')

map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

map("n", "Q", "<nop>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- LSP
-- setup formatting and keymaps
map("n", "<leader>cd", vim.diagnostic.open_float, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
-- this two are already by default in lsp-zero
-- map("n", "<leader>gd", vim.lsp.buf.definition, opts)
-- map("n", "<leader>gD", vim.lsp.buf.declaration, opts)
map("n", "<leader>fA", "<cmd>EslintFixAll<CR>")
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>fa", function()
	vim.lsp.buf.format()
end)
-- map("n", "<leader>fa", function()
-- 	vim.lsp.buf.format({
-- 		filter = function(clients)
-- 			return vim.tbl_filter(function(client)
-- 				return client.name ~= "tsserver"
-- 			end, clients)
-- 		end,
-- 	})
-- end, opts)
