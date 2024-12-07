local map = vim.keymap.set
vim.g.mapleader = " "

-- Move Lines
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move selection down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move selection down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move selection up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move selection up" })

-- jump 1 page down/up
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- INFO: use this only when vim-tmux-navigator is not installed
-- jump to split
map("n", "<c-k>", ":wincmd k<CR>")
map("n", "<c-j>", ":wincmd j<CR>")
map("n", "<c-h>", ":wincmd h<CR>")
map("n", "<c-l>", ":wincmd l<CR>")

-- use system clipboard
-- yank
map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+y', { desc = "Yank to clipboard" })
-- paste
map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste from clipboard" })
map("x", "<leader>p", '"_dp', { desc = "Paste but don't save to buffer" })
-- delete
map("n", "<leader>d", '"_d', { desc = "Delete without copy to clipboard" })
map("v", "<leader>d", '"_d', { desc = "Delete without copy to clipboard" })

map("n", "Q", "<nop>", { desc = "Does nothing, that's the point" })
map("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace word under cursor" })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Resize pane with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Navigate between quickfix items
map("n", "<leader>h", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
map("n", "<leader>l", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- MACROS
map("n", "Q", "@qj", { desc = "Run macro q" })
map("x", "Q", ":norm @q<CR>", { desc = "Run macro q in all selected lines" })

-- GOLANG error check snippet
map("n", "<leader>hh", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "insert error check for golang" })

-- JAVASCRIPT multiline comment
map("n", "<leader>cc", function()
  local line = vim.fn.line(".")
  vim.fn.append(line - 1, "/**")
  vim.fn.append(line, " * ")
  vim.fn.append(line + 1, " */")
  vim.cmd("normal! k")
  vim.cmd("normal! k")
  vim.cmd("startinsert!")
end, { desc = "Insert multiline JS comment", silent = true })

-- CHANGE COLORSCHEME
local colorschemes = { "catppuccin-mocha", "catppuccin-latte" }
local current_index = 1
function Toggle_colorscheme()
  current_index = current_index % #colorschemes + 1
  vim.cmd("colorscheme " .. colorschemes[current_index])
  print("Colorscheme switched to " .. colorschemes[current_index])
end

map("n", "<leader>cs", "<cmd>lua Toggle_colorscheme()<CR>", { desc = "Change colorscheme mocha/latte" })
