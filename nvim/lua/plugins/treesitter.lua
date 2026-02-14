return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
  end,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>",      desc = "Schrink selection",  mode = "x" },
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
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
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      },
    },
  },
  -- config = function(_, opts)
  --   require("nvim-treesitter.configs").setup(opts)
  -- end,
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    -- FIX: override textobject moves AFTER everything is loaded
    local ok, move = pcall(require, "nvim-treesitter.textobjects.move")
    if not ok then
      return
    end

    local configs = require("nvim-treesitter.configs")

    for name, fn in pairs(move) do
      if name:find("goto") == 1 then
        move[name] = function(q, ...)
          if vim.wo.diff then
            local config = configs.get_module("textobjects.move")[name]
            for key, query in pairs(config or {}) do
              if q == query and key:find("[%]%[][cC]") then
                vim.cmd("normal! " .. key)
                return
              end
            end
          end
          return fn(q, ...)
        end
      end
    end
  end,
  -- config = function()
  --   local ok_move, move = pcall(require, "nvim-treesitter.textobjects.move")
  --   local ok_cfg, configs = pcall(require, "nvim-treesitter.configs")
  --   if not (ok_move and ok_cfg) then
  --     return
  --   end
  --
  --   for name, fn in pairs(move) do
  --     if type(fn) == "function" and name:find("^goto") then
  --       move[name] = function(q, ...)
  --         if vim.wo.diff then
  --           local mod = configs.get_module("textobjects.move") or {}
  --           local conf = mod[name] or {}
  --           for key, query in pairs(conf) do
  --             if q == query and key:find("[%]%[][cC]") then
  --               vim.cmd("normal! " .. key)
  --               return
  --             end
  --           end
  --         end
  --         return fn(q, ...)
  --       end
  --     end
  --   end
  -- end
}
