local M = {}
local root_patterns = { ".git", "lua" }

-- Get the root directory of the current buffer.
local function get_root()
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace
          and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, workspace)
          or client.config.root_dir and { client.config.root_dir }
          or {}
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

-- Call a telescope builtin with the current root directory.
---@param builtin any
---@param opts any
---@return function
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

-- Check if a plugin is installed.
---@param plugin any
---@return boolean
local function has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

-- Get the foreground color of a highlight group.
---@param name any
---@return function
local function fg(name)
  return function()
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
  end
end

-- Function to populate quickfix list with diagnostics of current file
---@return nil
local function populate_quickfix_with_diagnostics()
  local diagnostics = vim.diagnostic.get()
  local qflist = {}
  for _, diag in ipairs(diagnostics) do
    table.insert(qflist, {
      bufnr = diag.bufnr,
      lnum = diag.lnum + 1,
      col = diag.col + 1,
      text = diag.message,
      type = diag.severity == vim.diagnostic.severity.ERROR and 'E'
          or diag.severity == vim.diagnostic.severity.WARN and 'W'
          or diag.severity == vim.diagnostic.severity.INFO and 'I'
          or diag.severity == vim.diagnostic.severity.HINT and 'H',
    })
  end
  vim.fn.setqflist(qflist, 'r')
  vim.cmd('copen')
end

M.get_root = get_root
M.telescope_utils = telescope_utils
M.has = has
M.fg = fg
M.diagnostics_list = populate_quickfix_with_diagnostics

return M
