vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move highlighted text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d", "<C-d>zz")
vim.keymap.set("n", "<C-u", "<C-u>zz")

-- paste but don't save to buffer
vim.keymap.set("x", "<leader>p", "\"_dp")

-- use system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)
vim.keymap.set("n", "<leader>fa", "<cmd>EslintFixAll<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- BARBAR --
local opts = { noremap = true, silent = true}
-- Move to previous/next buffer
vim.keymap.set("n", "<A-,>", "<cmd>BufferPrevious<CR>", opts)
vim.keymap.set("n", "<A-.>", "<cmd>BufferNext<CR>", opts)
-- Go to buffer in position
vim.keymap.set("n", "<A-1>", "<cmd>BufferGoto 1<CR>", opts)
vim.keymap.set("n", "<A-2>", "<cmd>BufferGoto 2<CR>", opts)
vim.keymap.set("n", "<A-3>", "<cmd>BufferGoto 3<CR>", opts)
vim.keymap.set("n", "<A-4>", "<cmd>BufferGoto 4<CR>", opts)
vim.keymap.set("n", "<A-5>", "<cmd>BufferGoto 5<CR>", opts)
vim.keymap.set("n", "<A-6>", "<cmd>BufferGoto 6<CR>", opts)
vim.keymap.set("n", "<A-7>", "<cmd>BufferGoto 7<CR>", opts)
vim.keymap.set("n", "<A-8>", "<cmd>BufferGoto 8<CR>", opts)
vim.keymap.set("n", "<A-9>", "<cmd>BufferGoto 9<CR>", opts)
vim.keymap.set("n", "<A-0>", "<cmd>BufferGoto 0<CR>", opts)
-- Pin/unpin buffer
vim.keymap.set("n", "<A-p>", "<cmd>BufferPin<CR>", opts)
vim.keymap.set("n", "<A-c>", "<cmd>BufferClose<CR>", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Naviagate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")

-- Nvim-tree mappings
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
