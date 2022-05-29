local o = vim.o
local wo = vim.wo
local b = vim.b

wo.number = true
wo.relativenumber = true
o.shell = "/bin/zsh"
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.nu = true
o.laststatus = 0
o.hidden = true
o.splitright = true
o.cmdheight = 1

-- THEME --
b.syntax = true
vim.cmd('colorscheme dracula')
