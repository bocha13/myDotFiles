local map = vim.keymap.set
vim.g.mapleader = " "

map("n", "<leader>pv", vim.cmd.Ex)

-- move highlighted text
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-d", "<C-d>zz")
map("n", "<C-u", "<C-u>zz")

-- paste but don't save to buffer
map("x", "<leader>p", "\"_dp")

-- use system clipboard
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")

map("n", "<leader>d", "\"_d")
map("v", "<leader>d", "\"_d")

map("n", "Q", "<nop>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
map("n", "<leader>f", function()
  vim.lsp.buf.format()
end)
map("n", "<leader>fa", "<cmd>EslintFixAll<CR>")

map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- BARBAR --
local opts = { noremap = true, silent = true }
-- Move to previous/next buffer
map("n", "<A-,>", "<cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<cmd>BufferNext<CR>", opts)
-- Go to buffer in position
map("n", "<A-1>", "<cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<cmd>BufferGoto 0<CR>", opts)
-- Pin/unpin buffer
map("n", "<A-p>", "<cmd>BufferPin<CR>", opts)
map("n", "<A-c>", "<cmd>BufferClose<CR>", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Naviagate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Nvim-tree mappings
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- TELESCOPE
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>fg', builtin.git_files, {})
map('n', '<leader>ft', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fp', function()
  builtin.gre_string({ search = vim.fn.input("Grep > ") });
end)

-- UNDOTREE
map("n", "<leader>u", vim.cmd.UndotreeToggle)
