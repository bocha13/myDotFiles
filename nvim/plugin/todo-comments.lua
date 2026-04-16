vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })

local icons = require("utils").icons

require("todo-comments").setup({
  signs = true,
  sign_priority = 8,
  keywords = {
    FIX = { icon = icons.todo.fix, color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
    TODO = { icon = icons.todo.todo, color = "info" },
    HACK = { icon = icons.todo.hack, color = "warning" },
    WARN = { icon = icons.todo.warn, color = "warning" },
    PERF = { icon = icons.todo.perf, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = icons.todo.note, color = "hint", alt = { "INFO" } },
    TEST = { icon = icons.todo.test, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
  gui_style = {
    fg = "NONE",
    bg = "BOLD",
  },
  merge_keywords = true,
  highlight = {
    multiline = false,
    before = "bg",
    keyword = "bg",
    after = "fg",
    pattern = [[.*<(KEYWORDS)\s*]],
    comments_only = true,
    max_line_len = 400,
    exclude = {},
  },
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
    test = { "Identifier", "#FF00FF" },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    pattern = [[\b(KEYWORDS):]],
  },
})

vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Todo" })
vim.keymap.set("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme" })
vim.keymap.set("n", "<leader>dt", "<Cmd>exe ':TodoQuickFix cwd=' .. fnameescape(expand('%:p'))<CR>",
  { desc = "search TODOs in current file" })
