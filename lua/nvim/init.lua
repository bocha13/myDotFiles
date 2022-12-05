local options = {
	termguicolors = true,
	-- cursorline = true, -- Highlight the text line of the cursor
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	-- colorcolumn = "80",
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	timeoutlen = 1000,
	undofile = true,
	updatetime = 300,
	writebackup = false,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	number = true,
	laststatus = 3,
	showcmd = false,
	ruler = false,
	relativenumber = true,
	numberwidth = 4,
	signcolumn = "yes",
	wrap = false,
	scrolloff = 8,
	sidescrolloff = 8,
	guifont = "JetBrainsMono:17",
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

-- source remining config giles
require("plugins")
require("autocommands")
require("keymaps")
require("lsp")
require("plugins.illuminate")

vim.opt.fillchars.eob = " "
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
