vim.opt.guicursor = ""

-- NETRW
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_liststyle = 0
-- vim.g.netrw_banner = 1
vim.g.netrw_list_hide = "(^|ss)\zs.S+"
vim.g.netrw_localcopydircmd = "cp -r"

vim.api.nvim_command("set fillchars+=vert:\\▎")

-- remove auto comment on new line after comment
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})

-- make nvim detect Jenkinsfile as groovy for syntax highlighting
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("setlocal filetype=groovy")
  end,
  group = general,
  pattern = "Jenkinsfile",
  desc = "Set Jenkinsfile filetype",
})

vim.opt.showmode = false
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
-- vim.opt.cursorline = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- VIM-FUGITIVE
-- set gitgutter to always be vertical
vim.opt.diffopt = "vertical"

vim.g.mapleader = " "

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})
