local os_utils = require("utils")

vim.opt.guicursor = ""

-- NETRW
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_liststyle = 0
-- vim.g.netrw_banner = 1
vim.g.netrw_list_hide = "(^|ss)\zs.S+"
vim.g.netrw_localcopydircmd = "cp -r"

-- change split separator character
vim.opt.fillchars:append({
  vert      = "┃",
  horiz     = "━",
  horizup   = "┻",
  horizdown = "┳",
  vertleft  = "┫",
  vertright = "┣",
  verthoriz = "╋",
})

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

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

-- this is to have yank in wsl, requires the following dependencies
-- install in WSL:
-- curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip
-- unzip -p /tmp/win32yank.zip win32yank.exe > ~/.local/bin/win32yank.exe
-- chmod +x ~/.local/bin/win32yank.exe

--then add this to the path:
-- export PATH="$HOME/.local/bin:$PATH"
if vim.fn.executable('win32yank.exe') == 1 then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = false,
  }
end

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
vim.opt.undodir = os_utils.get_home() .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.cursorline = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- VIM-FUGITIVE
-- set gitgutter to always be vertical
vim.opt.diffopt = "vertical"

vim.g.mapleader = " "

-- Format on save only use one of these
-- NATIVE
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })
-- CONFORM
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })
