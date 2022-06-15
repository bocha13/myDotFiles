local options = {
	termguicolors = true,         -- Enables 24-bit RGB color
	cursorline = true,	      -- Highlight the text line of the cursor
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt =  {"menuone", "noselect"},
	conceallevel = 0,
	-- colorcolumn = "80",
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 0,
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
	cursorline = true,
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
	guifont = "monospace:h17"
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

-- INLINE CONFIG
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.fillchars.eob=" "
vim.opt.shortmess:append "c"
