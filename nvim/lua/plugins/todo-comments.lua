local icons = require("utils").icons

return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "BufReadPost",
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
    { "<leader>xt", "<cmd>TodoTrouble<cr>",                           desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",   desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>st", "<cmd>TodoTelescope<cr>",                         desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    {
      "<leader>dt",
      "<Cmd>exe ':TodoQuickFix cwd=' .. fnameescape(expand('%:p'))<CR>",
      desc = "search TODOs in current file",
    },
    -- TODO: sd ^,
  },
  config = function()
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
  end,
}
