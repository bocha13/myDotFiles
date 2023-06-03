local map = vim.keymap.set
vim.g.mapleader = " "

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
-- yank
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+y')
-- paste
map("n", "<leader>p", '"+p')
map("v", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')

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
