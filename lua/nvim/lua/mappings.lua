local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

vim.g.mapleader = ' '

mapper("n", "<leader>b", ":Vex<CR>")
mapper("n", "<leader>h", ":wincmd h<CR>")
mapper("n", "<leader>j", ":wincmd j<CR>")
mapper("n", "<leader>k", ":wincmd k<CR>")
mapper("n", "<leader>l", ":wincmd l<CR>")
mapper("n", "<leader>pv", ":wincmd v<bar> :Ex <bar> :vertical resize 30<CR>")
mapper("n", "<leader>+", ":vertical resize +5<CR>")
mapper("n", "<leader>-", ":vertical resize -5<CR>")
mapper("n", "rp", ":resize 100")
mapper("n", "<C-Left>", ":tabprevious")
mapper("n", "<C-Right>", ":tabnext")
mapper("n", "<C-j>", ":tabprevious")
mapper("n", "<C-k>", ":tabnext")
mapper("n", "{<CR>", "{<CR>}<Esc>ko")
mapper("n", "[<CR>", "[<CR>]<Esc>ko")
mapper("n", "(<CR>", "(<CR>)<Esc>ko")
mapper("n", "<leader>ff", ":Telescope find_files<CR>")
mapper("n", "<leader>gf", ":Telescope git_files<CR>")
