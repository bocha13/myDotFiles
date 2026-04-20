vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local bufremove = require("mini.bufremove")
local surround = require("mini.surround")
local indentscope = require("mini.indentscope")
local pairs = require("mini.pairs")
local tabline = require("mini.tabline")

pairs.setup({})
bufremove.setup({})
tabline.setup({
  show_icons = false,
  format = function(buf_id, label)
    local has_errors = #vim.diagnostic.get(buf_id, { severity = vim.diagnostic.severity.ERROR }) > 0
    local suffix = (has_errors) and " ●" or ""
    return " " .. tabline.default_format(buf_id, label) .. suffix .. " "
  end,
  tabpage_section = 'left'
})
surround.setup({
  mappings = {
    add = "gza",
    delete = "gzd",
    find = "gzf",
    find_left = "gzF",
    highlight = "gzh",
    replace = "gzr",
    update_n_lines = "gzn",
  },
})
indentscope.setup({
  symbol = "│",
  options = { try_as_border = true },
})

local base16 = require("mini.base16")
base16.setup({
  palette = {
    base00 = "#1d2021", -- base (background)
    base01 = "#191b1c", -- mantle
    base02 = "#292929", -- surface0
    base03 = "#404040", -- surface1
    base04 = "#4d4d4d", -- surface2
    base05 = "#ebdbb2", -- text (foreground)
    base06 = "#d5c4a1", -- subtext1
    base07 = "#bdae93", -- subtext0
    base08 = "#ea6962", -- red
    base09 = "#e78a4e", -- peach
    base0A = "#d8a657", -- yellow
    base0B = "#a9b665", -- green
    base0C = "#89b482", -- teal/sky/sapphire
    base0D = "#7daea3", -- blue
    base0E = "#d3869b", -- mauve/pink
    base0F = "#141617", -- crust
  },
  use_cterm = false,
})

local p = {
  base     = "#1d2021",
  mantle   = "#191b1c",
  crust    = "#141617",
  surface0 = "#292929",
  surface1 = "#404040",
  surface2 = "#4d4d4d",
  overlay0 = "#595959",
  overlay1 = "#928374",
  text     = "#ebdbb2",
  subtext1 = "#d5c4a1",
  subtext0 = "#bdae93",
  red      = "#ea6962",
  peach    = "#e78a4e",
  yellow   = "#d8a657",
  green    = "#a9b665",
  teal     = "#89b482",
  blue     = "#7daea3",
  lavender = "#7c9fad",
  mauve    = "#d3869b",
}

local hi = function(name, opts) vim.api.nvim_set_hl(0, name, opts) end

-- UI overrides
hi("CmpItemMenu", { fg = p.surface2 })
hi("CursorLineNr", { fg = p.text, bg = p.surface0 })
hi("CursorLine", { bg = p.surface0 })
hi("FloatBorder", { bg = p.overlay0, fg = p.surface2 })
hi("GitSignsChange", { fg = p.blue })
hi("GitsignsAdd", { fg = p.teal })
hi("gitsignsDelete", { fg = p.red })
hi("LineNrAbove", { fg = p.overlay0 })
hi("LineNrBelow", { fg = p.overlay0 })
hi("LineNrNC", { fg = p.overlay0 })
hi("LspInfoBorder", { link = "FloatBorder" })
hi("NormalFloat", { bg = p.crust })
hi("Pmenu", { bg = p.crust, fg = p.text })
hi("PmenuSel", { bg = p.surface0, fg = p.text })
hi("TelescopePreviewBorder", { bg = p.crust, fg = p.crust })
hi("TelescopePreviewNormal", { bg = p.crust })
hi("TelescopePreviewTitle", { fg = p.surface2, bg = p.crust })
hi("TelescopePromptBorder", { bg = p.surface0, fg = p.surface0 })
hi("TelescopePromptCounter", { fg = p.mauve, bold = true })
hi("TelescopePromptNormal", { bg = p.surface0 })
hi("TelescopePromptPrefix", { bg = p.surface0 })
hi("TelescopePromptTitle", { fg = p.text, bg = p.surface0 })
hi("TelescopeResultsBorder", { bg = p.mantle, fg = p.mantle })
hi("TelescopeResultsNormal", { bg = p.mantle })
hi("TelescopeResultsTitle", { fg = p.surface2, bg = p.mantle })
hi("TelescopeSelection", { bg = p.surface0 })
hi("WinSeparator", { bg = p.base, fg = p.blue })
hi("YankHighlight", { bg = p.surface2 })
hi("FidgetTask", { fg = p.text })
hi("FidgetTitle", { fg = p.peach })
hi("FloatTitle", { fg = p.text, bg = p.surface0, bold = true })
hi("FloatFooter", { fg = p.surface2, bg = p.surface0, italic = true })
hi("IblIndent", { fg = p.surface0 })
hi("IblScope", { fg = p.overlay0 })

-- Syntax overrides
hi("Boolean", { fg = p.mauve })
hi("Number", { fg = p.mauve })
hi("Float", { fg = p.mauve })
hi("PreProc", { fg = p.mauve })
hi("PreCondit", { fg = p.mauve })
hi("Include", { fg = p.mauve })
hi("Define", { fg = p.mauve })
hi("Conditional", { fg = p.red })
hi("Repeat", { fg = p.red })
hi("Keyword", { fg = p.red })
hi("Typedef", { fg = p.red })
hi("Exception", { fg = p.red })
hi("Statement", { fg = p.red })
hi("Error", { fg = p.red })
hi("StorageClass", { fg = p.peach })
hi("Tag", { fg = p.peach })
hi("Label", { fg = p.peach })
hi("Structure", { fg = p.peach })
hi("Operator", { fg = p.peach })
hi("Title", { fg = p.peach })
hi("Special", { fg = p.yellow })
hi("SpecialChar", { fg = p.yellow })
hi("Type", { fg = p.yellow, bold = true })
hi("Function", { fg = p.green, bold = true })
hi("Delimiter", { fg = p.text })
hi("Ignore", { fg = p.text })
hi("Macro", { fg = p.teal })

-- Treesitter
hi("TSAnnotation", { fg = p.mauve })
hi("TSAttribute", { fg = p.mauve })
hi("TSBoolean", { fg = p.mauve })
hi("TSCharacter", { fg = p.teal })
hi("TSCharacterSpecial", { link = "SpecialChar" })
hi("TSComment", { link = "Comment" })
hi("TSConditional", { fg = p.red })
hi("TSConstBuiltin", { fg = p.mauve })
hi("TSConstMacro", { fg = p.mauve })
hi("TSConstant", { fg = p.text })
hi("TSConstructor", { fg = p.green })
hi("TSDebug", { link = "Debug" })
hi("TSDefine", { link = "Define" })
hi("TSEnvironment", { link = "Macro" })
hi("TSEnvironmentName", { link = "Type" })
hi("TSError", { link = "Error" })
hi("TSException", { fg = p.red })
hi("TSField", { fg = p.blue })
hi("TSFloat", { fg = p.mauve })
hi("TSFuncBuiltin", { fg = p.green })
hi("TSFuncMacro", { fg = p.green })
hi("TSFunction", { fg = p.green })
hi("TSFunctionCall", { fg = p.green })
hi("TSInclude", { fg = p.red })
hi("TSKeyword", { fg = p.red })
hi("TSKeywordFunction", { fg = p.red })
hi("TSKeywordOperator", { fg = p.peach })
hi("TSKeywordReturn", { fg = p.red })
hi("TSLabel", { fg = p.peach })
hi("TSLiteral", { link = "String" })
hi("TSMath", { fg = p.blue })
hi("TSMethod", { fg = p.green })
hi("TSMethodCall", { fg = p.green })
hi("TSNamespace", { fg = p.yellow })
hi("TSNone", { fg = p.text })
hi("TSNumber", { fg = p.mauve })
hi("TSOperator", { fg = p.peach })
hi("TSParameter", { fg = p.text })
hi("TSParameterReference", { fg = p.text })
hi("TSPreProc", { link = "PreProc" })
hi("TSProperty", { fg = p.blue })
hi("TSPunctBracket", { fg = p.text })
hi("TSPunctDelimiter", { link = "Delimiter" })
hi("TSPunctSpecial", { fg = p.blue })
hi("TSRepeat", { fg = p.red })
hi("TSStorageClass", { fg = p.peach })
hi("TSStorageClassLifetime", { fg = p.peach })
hi("TSStrike", { fg = p.text })
hi("TSString", { fg = p.teal })
hi("TSStringEscape", { fg = p.green })
hi("TSStringRegex", { fg = p.green })
hi("TSStringSpecial", { link = "SpecialChar" })
hi("TSSymbol", { fg = p.text })
hi("TSTag", { fg = p.peach })
hi("TSTagAttribute", { fg = p.green })
hi("TSTagDelimiter", { fg = p.green })
hi("TSText", { fg = p.green })
hi("TSTextReference", { link = "Constant" })
hi("TSTitle", { link = "Title" })
hi("TSTodo", { link = "Todo" })
hi("TSType", { fg = p.yellow, bold = true })
hi("TSTypeBuiltin", { fg = p.yellow, bold = true })
hi("TSTypeDefinition", { fg = p.yellow, bold = true })
hi("TSTypeQualifier", { fg = p.peach, bold = true })
hi("TSURI", { fg = p.blue })
hi("TSVariable", { fg = p.text })
hi("TSVariableBuiltin", { fg = p.mauve })

-- @-style treesitter captures
hi("@annotation", { link = "TSAnnotation" })
hi("@attribute", { link = "TSAttribute" })
hi("@boolean", { link = "TSBoolean" })
hi("@character", { link = "TSCharacter" })
hi("@character.special", { link = "TSCharacterSpecial" })
hi("@comment", { link = "TSComment" })
hi("@conceal", { link = "Grey" })
hi("@conditional", { link = "TSConditional" })
hi("@constant", { link = "TSConstant" })
hi("@constant.builtin", { link = "TSConstBuiltin" })
hi("@constant.macro", { link = "TSConstMacro" })
hi("@constructor", { link = "TSConstructor" })
hi("@debug", { link = "TSDebug" })
hi("@define", { link = "TSDefine" })
hi("@error", { link = "TSError" })
hi("@exception", { link = "TSException" })
hi("@field", { link = "TSField" })
hi("@float", { link = "TSFloat" })
hi("@function", { link = "TSFunction" })
hi("@function.builtin", { link = "TSFuncBuiltin" })
hi("@function.call", { link = "TSFunctionCall" })
hi("@function.macro", { link = "TSFuncMacro" })
hi("@include", { link = "TSInclude" })
hi("@keyword", { link = "TSKeyword" })
hi("@keyword.function", { link = "TSKeywordFunction" })
hi("@keyword.operator", { link = "TSKeywordOperator" })
hi("@keyword.return", { link = "TSKeywordReturn" })
hi("@label", { link = "TSLabel" })
hi("@math", { link = "TSMath" })
hi("@method", { link = "TSMethod" })
hi("@method.call", { link = "TSMethodCall" })
hi("@namespace", { link = "TSNamespace" })
hi("@none", { link = "TSNone" })
hi("@number", { link = "TSNumber" })
hi("@operator", { link = "TSOperator" })
hi("@parameter", { link = "TSParameter" })
hi("@parameter.reference", { link = "TSParameterReference" })
hi("@preproc", { link = "TSPreProc" })
hi("@property", { link = "TSProperty" })
hi("@punctuation.bracket", { link = "TSPunctBracket" })
hi("@punctuation.delimiter", { link = "TSPunctDelimiter" })
hi("@punctuation.special", { link = "TSPunctSpecial" })
hi("@repeat", { link = "TSRepeat" })
hi("@storageclass", { link = "TSStorageClass" })
hi("@storageclass.lifetime", { link = "TSStorageClassLifetime" })
hi("@strike", { link = "TSStrike" })
hi("@string", { link = "TSString" })
hi("@string.escape", { link = "TSStringEscape" })
hi("@string.regex", { link = "TSStringRegex" })
hi("@string.special", { link = "TSStringSpecial" })
hi("@symbol", { link = "TSSymbol" })
hi("@tag", { link = "TSTag" })
hi("@tag.attribute", { link = "TSTagAttribute" })
hi("@tag.delimiter", { link = "TSTagDelimiter" })
hi("@text", { link = "TSText" })
hi("@text.danger", { link = "TSDanger" })
hi("@text.diff.add", { link = "diffAdded" })
hi("@text.diff.delete", { link = "diffRemoved" })
hi("@text.emphasis", { link = "TSEmphasis" })
hi("@text.environment", { link = "TSEnvironment" })
hi("@text.environment.name", { link = "TSEnvironmentName" })
hi("@text.literal", { link = "TSLiteral" })
hi("@text.math", { link = "TSMath" })
hi("@text.note", { link = "TSNote" })
hi("@text.reference", { link = "TSTextReference" })
hi("@text.strike", { link = "TSStrike" })
hi("@text.strong", { link = "TSStrong" })
hi("@text.title", { link = "TSTitle" })
hi("@text.todo", { link = "TSTodo" })
hi("@text.todo.checked", { link = "Green" })
hi("@text.todo.unchecked", { link = "Ignore" })
hi("@text.underline", { link = "TSUnderline" })
hi("@text.uri", { link = "TSURI" })
hi("@text.warning", { link = "TSWarning" })
hi("@todo", { link = "TSTodo" })
hi("@type", { link = "TSType" })
hi("@type.builtin", { link = "TSTypeBuiltin" })
hi("@type.definition", { link = "TSTypeDefinition" })
hi("@type.qualifier", { link = "TSTypeQualifier" })
hi("@uri", { link = "TSURI" })
hi("@variable", { link = "TSVariable" })
hi("@variable.builtin", { link = "TSVariableBuiltin" })

-- LSP semantic tokens
hi("@lsp.type.class", { link = "TSType" })
hi("@lsp.type.comment", { link = "TSComment" })
hi("@lsp.type.decorator", { link = "TSFunction" })
hi("@lsp.type.enum", { link = "TSType" })
hi("@lsp.type.enumMember", { link = "TSProperty" })
hi("@lsp.type.events", { link = "TSLabel" })
hi("@lsp.type.function", { link = "TSFunction" })
hi("@lsp.type.interface", { link = "TSType" })
hi("@lsp.type.keyword", { link = "TSKeyword" })
hi("@lsp.type.macro", { link = "TSConstMacro" })
hi("@lsp.type.method", { link = "TSMethod" })
hi("@lsp.type.modifier", { link = "TSTypeQualifier" })
hi("@lsp.type.namespace", { link = "TSNamespace" })
hi("@lsp.type.number", { link = "TSNumber" })
hi("@lsp.type.operator", { link = "TSOperator" })
hi("@lsp.type.parameter", { link = "TSParameter" })
hi("@lsp.type.property", { link = "TSProperty" })
hi("@lsp.type.regexp", { link = "TSStringRegex" })
hi("@lsp.type.string", { link = "TSString" })
hi("@lsp.type.struct", { link = "TSType" })
hi("@lsp.type.type", { link = "TSType" })
hi("@lsp.type.typeParameter", { link = "TSTypeDefinition" })
hi("@lsp.type.variable", { link = "TSVariable" })

-- Visual selection
hi("Visual", { bg = p.surface2 })

-- MiniTabline
hi("MiniTablineCurrent", { fg = p.text, bg = p.surface1, bold = true })
hi("MiniTablineHidden", { fg = p.overlay1, bg = p.crust, bold = true })
hi("MiniTablineModifiedCurrent", { fg = p.teal, bg = p.surface1, bold = true })
hi("MiniTablineModifiedHidden", { fg = p.teal, bg = p.crust, bold = true })
