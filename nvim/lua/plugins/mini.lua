return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
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
          if (vim.bo[buf_id].modified) then
            return " " .. MiniTabline.default_format(buf_id, label) .. " "
          end

          return " " .. MiniTabline.default_format(buf_id, label) .. " "
        end,
        tabpage_section = 'left'
      })
      surround.setup({
        mappings = {
          add = "gza",            -- Add surrounding in Normal and Visual modes
          delete = "gzd",         -- Delete surrounding
          find = "gzf",           -- Find surrounding (to the right)
          find_left = "gzF",      -- Find surrounding (to the left)
          highlight = "gzh",      -- Highlight surrounding
          replace = "gzr",        -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`
        },
      })
      indentscope.setup({
        symbol = "│",
        options = { try_as_border = true },
      })

      -- Setup colorscheme with mini.colors
      local has_colors, minicolors = pcall(require, "mini.colors")
      if has_colors then
        -- Define the color palette (Gruvbox-inspired)
        local palette = {
          -- Primary colors
          red = "#ea6962",
          pink = "#d3869b",
          peach = "#e78a4e",
          yellow = "#d8a657",
          green = "#a9b665",
          teal = "#89b482",
          blue = "#7daea3",
          lavender = "#7c9fad",

          -- Text colors
          text = "#ebdbb2",
          subtext1 = "#d5c4a1",
          subtext0 = "#bdae93",

          -- Overlay colors
          overlay2 = "#a89984",
          overlay1 = "#928374",
          overlay0 = "#595959",

          -- Surface colors
          surface2 = "#4d4d4d",
          surface1 = "#404040",
          surface0 = "#292929",

          -- Base colors
          base = "#1d2021",
          mantle = "#191b1c",
          crust = "#141617",
        }

        -- Create and apply colorscheme
        local colorscheme = minicolors.as_colorscheme({
          name = "gruvbox-mini",
          groups = {
            -- Editor UI
            Normal = { fg = palette.text, bg = palette.base },
            NormalFloat = { bg = palette.crust },
            FloatBorder = { bg = palette.overlay0, fg = palette.surface2 },
            FloatTitle = { fg = palette.text, bg = palette.surface0, bold = true },
            FloatFooter = { fg = palette.surface2, bg = palette.surface0, italic = true },
            CursorLine = { bg = palette.surface0 },
            CursorLineNr = { fg = palette.text, bg = palette.surface0 },
            LineNr = { fg = palette.overlay0 },
            LineNrAbove = { fg = palette.overlay0 },
            LineNrBelow = { fg = palette.overlay0 },
            WinSeparator = { bg = palette.base, fg = palette.blue },
            Visual = { bg = palette.overlay0 }, -- #595959

            -- Pmenu (completion menu)
            Pmenu = { bg = palette.crust, fg = palette.text },
            PmenuSel = { bg = palette.surface0, fg = palette.text },
            CmpItemMenu = { fg = palette.surface2 },
            PmenuKind = { fg = palette.blue, bg = palette.crust },
            PmenuExtra = { fg = palette.overlay2, bg = palette.crust },
            PmenuSbar = { bg = palette.surface0 },
            PmenuThumb = { bg = palette.overlay0 },

            -- Git signs (signcolumn)
            GitSignsChange = { fg = palette.blue },
            GitSignsAdd = { fg = palette.teal },
            GitSignsDelete = { fg = palette.red },
            GitSignsUntracked = { fg = palette.yellow },

            -- Git signs (inline virtual text)
            GitSignsAddInline = { bg = palette.teal, fg = palette.base },
            GitSignsChangeInline = { bg = palette.blue, fg = palette.base },
            GitSignsDeleteInline = { bg = palette.red, fg = palette.base },

            -- Git signs (line highlights)
            GitSignsAddLn = { bg = "#2e5049" },
            GitSignsChangeLn = { bg = "#344f69" },
            GitSignsDeleteLn = { bg = "#4a2c2c" },

            -- Git diff
            DiffAdd = { bg = "#2e5049", fg = palette.teal },
            DiffChange = { bg = "#344f69", fg = palette.blue },
            DiffDelete = { bg = "#4a2c2c", fg = palette.red },
            DiffText = { bg = "#4a6b8a", fg = palette.text, bold = true },

            -- Git conflict markers (used by git-conflict.nvim)
            GitConflictCurrent = { bg = "#2e5049" },
            GitConflictIncoming = { bg = "#344f69" },
            GitConflictCurrentLabel = { bg = "#2e5049", fg = palette.teal, bold = true },
            GitConflictIncomingLabel = { bg = "#344f69", fg = palette.blue, bold = true },
            GitConflictAncestor = { bg = "#3e3e3e" },

            -- Telescope
            TelescopePreviewBorder = { bg = palette.crust, fg = palette.crust },
            TelescopePreviewNormal = { bg = palette.crust },
            TelescopePreviewTitle = { fg = palette.surface2, bg = palette.crust },
            TelescopePromptBorder = { bg = palette.surface0, fg = palette.surface0 },
            TelescopePromptCounter = { fg = palette.pink, bold = true },
            TelescopePromptNormal = { bg = palette.surface0 },
            TelescopePromptPrefix = { bg = palette.surface0 },
            TelescopePromptTitle = { fg = palette.text, bg = palette.surface0 },
            TelescopeResultsBorder = { bg = palette.mantle, fg = palette.mantle },
            TelescopeResultsNormal = { bg = palette.mantle },
            TelescopeResultsTitle = { fg = palette.surface2, bg = palette.mantle },
            TelescopeSelection = { bg = palette.surface0 },

            -- LSP
            LspInfoBorder = { link = "FloatBorder" },

            -- Diagnostics
            DiagnosticError = { fg = palette.red },
            DiagnosticWarn = { fg = palette.yellow },
            DiagnosticInfo = { fg = palette.blue },
            DiagnosticHint = { fg = palette.teal },
            DiagnosticOk = { fg = palette.green },

            -- Diagnostic virtual text
            DiagnosticVirtualTextError = { fg = palette.red, bg = palette.base },
            DiagnosticVirtualTextWarn = { fg = palette.yellow, bg = palette.base },
            DiagnosticVirtualTextInfo = { fg = palette.blue, bg = palette.base },
            DiagnosticVirtualTextHint = { fg = palette.teal, bg = palette.base },

            -- Diagnostic underlines
            DiagnosticUnderlineError = { undercurl = true, sp = palette.red },
            DiagnosticUnderlineWarn = { undercurl = true, sp = palette.yellow },
            DiagnosticUnderlineInfo = { undercurl = true, sp = palette.blue },
            DiagnosticUnderlineHint = { undercurl = true, sp = palette.teal },

            -- Diagnostic signs (gutter)
            DiagnosticSignError = { fg = palette.red, bg = palette.base },
            DiagnosticSignWarn = { fg = palette.yellow, bg = palette.base },
            DiagnosticSignInfo = { fg = palette.blue, bg = palette.base },
            DiagnosticSignHint = { fg = palette.teal, bg = palette.base },

            -- Diagnostic floating window
            DiagnosticFloatingError = { fg = palette.red, bg = palette.crust },
            DiagnosticFloatingWarn = { fg = palette.yellow, bg = palette.crust },
            DiagnosticFloatingInfo = { fg = palette.blue, bg = palette.crust },
            DiagnosticFloatingHint = { fg = palette.teal, bg = palette.crust },

            -- Fidget
            FidgetTask = { fg = palette.text },
            FidgetTitle = { fg = palette.peach },

            -- Indent blankline
            IblIndent = { fg = palette.surface0 },
            IblScope = { fg = palette.overlay0 },

            -- Misc
            YankHighlight = { bg = palette.surface2 },

            -- Syntax groups
            Boolean = { fg = palette.pink },
            Number = { fg = palette.pink },
            Float = { fg = palette.pink },
            PreProc = { fg = palette.pink },
            PreCondit = { fg = palette.pink },
            Include = { fg = palette.pink },
            Define = { fg = palette.pink },
            Conditional = { fg = palette.red },
            Repeat = { fg = palette.red },
            Keyword = { fg = palette.red },
            Typedef = { fg = palette.red },
            Exception = { fg = palette.red },
            Statement = { fg = palette.red },
            Error = { fg = palette.red },
            StorageClass = { fg = palette.peach },
            Tag = { fg = palette.peach },
            Label = { fg = palette.peach },
            Structure = { fg = palette.peach },
            Operator = { fg = palette.peach },
            Title = { fg = palette.peach },
            Special = { fg = palette.yellow },
            SpecialChar = { fg = palette.yellow },
            Type = { fg = palette.yellow, bold = true },
            Function = { fg = palette.green, bold = true },
            Delimiter = { fg = palette.text },
            Ignore = { fg = palette.text },
            Macro = { fg = palette.teal },

            -- TreeSitter
            ["@annotation"] = { fg = palette.pink },
            ["@attribute"] = { fg = palette.pink },
            ["@boolean"] = { fg = palette.pink },
            ["@character"] = { fg = palette.teal },
            ["@character.special"] = { link = "SpecialChar" },
            ["@comment"] = { link = "Comment" },
            ["@conditional"] = { fg = palette.red },
            ["@constant"] = { fg = palette.text },
            ["@constant.builtin"] = { fg = palette.pink },
            ["@constant.macro"] = { fg = palette.pink },
            ["@constructor"] = { fg = palette.green },
            ["@debug"] = { link = "Debug" },
            ["@define"] = { link = "Define" },
            ["@error"] = { link = "Error" },
            ["@exception"] = { fg = palette.red },
            ["@field"] = { fg = palette.blue },
            ["@float"] = { fg = palette.pink },
            ["@function"] = { fg = palette.green },
            ["@function.builtin"] = { fg = palette.green },
            ["@function.call"] = { fg = palette.green },
            ["@function.macro"] = { fg = palette.green },
            ["@include"] = { fg = palette.red },
            ["@keyword"] = { fg = palette.red },
            ["@keyword.function"] = { fg = palette.red },
            ["@keyword.operator"] = { fg = palette.peach },
            ["@keyword.return"] = { fg = palette.red },
            ["@label"] = { fg = palette.peach },
            ["@math"] = { fg = palette.blue },
            ["@method"] = { fg = palette.green },
            ["@method.call"] = { fg = palette.green },
            ["@namespace"] = { fg = palette.yellow },
            ["@none"] = { fg = palette.text },
            ["@number"] = { fg = palette.pink },
            ["@operator"] = { fg = palette.peach },
            ["@parameter"] = { fg = palette.text },
            ["@parameter.reference"] = { fg = palette.text },
            ["@preproc"] = { link = "PreProc" },
            ["@property"] = { fg = palette.blue },
            ["@punctuation.bracket"] = { fg = palette.text },
            ["@punctuation.delimiter"] = { link = "Delimiter" },
            ["@punctuation.special"] = { fg = palette.blue },
            ["@repeat"] = { fg = palette.red },
            ["@storageclass"] = { fg = palette.peach },
            ["@storageclass.lifetime"] = { fg = palette.peach },
            ["@strike"] = { fg = palette.text },
            ["@string"] = { fg = palette.teal },
            ["@string.escape"] = { fg = palette.green },
            ["@string.regex"] = { fg = palette.green },
            ["@string.special"] = { link = "SpecialChar" },
            ["@symbol"] = { fg = palette.text },
            ["@tag"] = { fg = palette.peach },
            ["@tag.attribute"] = { fg = palette.green },
            ["@tag.delimiter"] = { fg = palette.green },
            ["@text"] = { fg = palette.green },
            ["@text.literal"] = { link = "String" },
            ["@text.reference"] = { link = "Constant" },
            ["@text.title"] = { link = "Title" },
            ["@text.todo"] = { link = "Todo" },
            ["@text.diff.add"] = { link = "diffAdded" },
            ["@text.diff.delete"] = { link = "diffRemoved" },
            ["@todo"] = { link = "Todo" },
            ["@type"] = { fg = palette.yellow, bold = true },
            ["@type.builtin"] = { fg = palette.yellow, bold = true },
            ["@type.definition"] = { fg = palette.yellow, bold = true },
            ["@type.qualifier"] = { fg = palette.peach, bold = true },
            ["@uri"] = { fg = palette.blue },
            ["@variable"] = { fg = palette.text },
            ["@variable.builtin"] = { fg = palette.pink },

            -- LSP Semantic Tokens
            ["@lsp.type.class"] = { fg = palette.yellow },
            ["@lsp.type.comment"] = { link = "Comment" },
            ["@lsp.type.decorator"] = { fg = palette.green },
            ["@lsp.type.enum"] = { fg = palette.yellow },
            ["@lsp.type.enumMember"] = { fg = palette.blue },
            ["@lsp.type.events"] = { fg = palette.peach },
            ["@lsp.type.function"] = { fg = palette.green },
            ["@lsp.type.interface"] = { fg = palette.yellow },
            ["@lsp.type.keyword"] = { fg = palette.red },
            ["@lsp.type.macro"] = { fg = palette.pink },
            ["@lsp.type.method"] = { fg = palette.green },
            ["@lsp.type.modifier"] = { fg = palette.peach, bold = true },
            ["@lsp.type.namespace"] = { fg = palette.yellow },
            ["@lsp.type.number"] = { fg = palette.pink },
            ["@lsp.type.operator"] = { fg = palette.peach },
            ["@lsp.type.parameter"] = { fg = palette.text },
            ["@lsp.type.property"] = { fg = palette.blue },
            ["@lsp.type.regexp"] = { fg = palette.green },
            ["@lsp.type.string"] = { fg = palette.teal },
            ["@lsp.type.struct"] = { fg = palette.yellow },
            ["@lsp.type.type"] = { fg = palette.yellow },
            ["@lsp.type.typeParameter"] = { fg = palette.yellow, bold = true },
            ["@lsp.type.variable"] = { fg = palette.text },
          }
        })

        colorscheme:apply()

        -- Apply tabline colors after colorscheme
        vim.api.nvim_set_hl(0, 'MiniTablineCurrent', {
          fg = palette.text,
          bg = palette.surface1,
          bold = true
        })
        vim.api.nvim_set_hl(0, 'MiniTablineHidden', {
          fg = palette.overlay2,
          bg = palette.crust,
          bold = true
        })
        vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', {
          fg = palette.green,
          bg = palette.surface1,
          bold = true
        })
        vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', {
          fg = palette.green,
          bg = palette.crust,
          bold = false
        })
        vim.api.nvim_set_hl(0, 'MiniTablineVisible', {
          fg = palette.subtext1,
          bg = palette.mantle,
          bold = false
        })
        vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', {
          fg = palette.green,
          bg = palette.mantle,
          bold = false
        })
        vim.api.nvim_set_hl(0, 'MiniTablineFill', {
          bg = palette.crust,
        })
        vim.api.nvim_set_hl(0, 'MiniTablineTabpagesection', {
          fg = palette.text,
          bg = palette.surface0,
          bold = true
        })

        -- Blink.cmp completion menu highlights
        vim.api.nvim_set_hl(0, 'BlinkCmpLabel', { fg = palette.text, bg = palette.crust })
        vim.api.nvim_set_hl(0, 'BlinkCmpLabelMatch', { fg = palette.green, bg = palette.crust, bold = true })
        vim.api.nvim_set_hl(0, 'BlinkCmpLabelDetail', { fg = palette.overlay2, bg = palette.crust })
        vim.api.nvim_set_hl(0, 'BlinkCmpLabelDescription', { fg = palette.subtext0, bg = palette.crust })

        -- Kind-specific colors (mapped to syntax colors)
        vim.api.nvim_set_hl(0, 'BlinkCmpKindText', { fg = palette.text })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindMethod', { fg = palette.green })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindFunction', { fg = palette.green })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindConstructor', { fg = palette.green })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindField', { fg = palette.blue })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindVariable', { fg = palette.text })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindClass', { fg = palette.yellow })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindInterface', { fg = palette.yellow })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindModule', { fg = palette.yellow })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindProperty', { fg = palette.blue })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindUnit', { fg = palette.pink })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindValue', { fg = palette.pink })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindEnum', { fg = palette.yellow })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindKeyword', { fg = palette.red })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindSnippet', { fg = palette.teal })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindColor', { fg = palette.pink })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindFile', { fg = palette.blue })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindReference', { fg = palette.peach })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindFolder', { fg = palette.blue })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindEnumMember', { fg = palette.blue })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindConstant', { fg = palette.pink })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindStruct', { fg = palette.yellow })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindEvent', { fg = palette.peach })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindOperator', { fg = palette.peach })
        vim.api.nvim_set_hl(0, 'BlinkCmpKindTypeParameter', { fg = palette.yellow })
      end
    end
  },
}
