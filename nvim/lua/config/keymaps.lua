local map = vim.keymap.set
vim.g.mapleader = " "

-- Move Lines
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move selection down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move selection down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move selection up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move selection up" })

map("n", "<C-d", "<C-d>zz")
map("n", "<C-u", "<C-u>zz")

map("x", "<leader>p", '"_dp', { desc = "Paste but don't save to buffer" })

-- use system clipboard
-- yank
map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+y', { desc = "Yank to clipboard" })
-- paste
map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste from clipboard" })

map("n", "<leader>d", '"_d', { desc = "Delete without copy to clipboard" })
map("v", "<leader>d", '"_d', { desc = "Delete without copy to clipboard" })

map("n", "Q", "<nop>", { desc = "Does nothing, that's the point" })
map("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")

map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace word under cursor" })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")
