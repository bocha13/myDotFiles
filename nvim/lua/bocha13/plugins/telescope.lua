local root_patterns = { ".git", "lua" }

local function get_root()
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  return root
end


local function telescope_utils(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = get_root() }, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope",
  version = false,
  keys = {
    -- find
    { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
    { "<leader>ff", telescope_utils("files"),         desc = "Find Files (root dir)" },
    { "<leader>fg", telescope_utils(),                desc = "Find Files (repo)" },
    { "<leader>ft", telescope_utils("live_grep"),   desc = "Word" },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>",  desc = "status" },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      file_ignore_patterns = { "node_modules" },
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      use_less = true,
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
  },
}
