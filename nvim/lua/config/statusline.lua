local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL-LINE",
	[""] = "VISUAL-BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT-LINE",
	[""] = "SELECT-BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL-REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM-EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#StatusLineAccent#"
	if current_mode == "n" then
		mode_color = "%#StatuslineAccent#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#StatuslineInsertAccent#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#StatuslineVisualAccent#"
	elseif current_mode == "R" then
		mode_color = "%#StatuslineReplaceAccent#"
	elseif current_mode == "c" then
		mode_color = "%#StatuslineCmdLineAccent#"
	elseif current_mode == "t" then
		mode_color = "%#StatuslineTerminalAccent#"
	end
	return mode_color
end

-- local function filepath()
-- 	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
-- 	if fpath == "" or fpath == "." then
-- 		return " "
-- 	end
--
-- 	return string.format(" %%<%s/", fpath)
-- end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError#E " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsSignWarning#W " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsSignHint#H " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsSignInformation#I " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#StatusLineNormal#"
end

-- local function filetype()
-- 	return string.format(" %s ", vim.bo.filetype):upper()
-- end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %P %l:%c "
end

Statusline = {}

Statusline.active = function()
	-- Material Gruvbox theme
	vim.cmd([[highlight StatuslineAccent guibg=#a89984 guifg=#282828]])
	vim.cmd([[highlight StatuslineVisualAccent guibg=#ea6962 guifg=#282828]])
	vim.cmd([[highlight StatuslineInsertAccent guibg=#458588 guifg=#FFFFFF]])
	vim.cmd([[highlight StatuslineReplaceAccent guibg=#ea6962 guifg=#282828]])
	vim.cmd([[highlight StatuslineCmdLineAccent guibg=#d3869b guifg=#282828]])
	vim.cmd([[highlight StatuslineTerminalAccent guibg=#a89984 guifg=#282828]])
	vim.cmd([[highlight LspDiagnosticsSignError guibg=#282828 guifg=#ea6962]])
	vim.cmd([[highlight LspDiagnosticsSignWarning guibg=#282828 guifg=#d8a657]])
	vim.cmd([[highlight LspDiagnosticsSignHint guibg=#282828 guifg=#7daea3]])
	vim.cmd([[highlight LspDiagnosticsSignInformation guibg=#282828 guifg=#7daea3]])
	vim.cmd([[highlight StatusLineExtra guibg=#a89984 guifg=#282828]])
	return table.concat({
		"%#Statusline#",
		update_mode_colors(),
		mode(),
		"%#StatusLineNormal# ",
		-- filepath(),
		filename(),
		"%#StatusLineNormal#",
		lsp(),
		"%=%#StatusLineExtra#",
		-- filetype(),
		lineinfo(),
	})
end

function Statusline.inactive()
	return " %F"
end

function Statusline.short()
	return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]],
	false
)
