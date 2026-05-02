vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = 'main'
  },
})

local TS = require("nvim-treesitter")

-- Update tree-sitter parsers whenever ‘nvim-treesitter’ is updated
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end
})

-- Enable highlighting
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    pcall(function()
      local lang = vim.treesitter.language.get_lang(ft)
      vim.treesitter.start(args.buf, lang)
    end)
  end,
})

TS.setup({
  context_commentstring = { enable = true, enable_autocmd = false },
  ensure_installed = {
    "astro",
    "bash",
    "css",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "query",
    "regex",
    "tsx",
    "typescript",
    "yaml",
  },
})
