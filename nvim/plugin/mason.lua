vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim"
})

local diagnostics_list = require("utils").diagnostics_list

local servers = {
  "astro",
  "clangd",
  "cssls",
  "eslint",
  "gopls",
  "html",
  "prismals",
  "jsonls",
  "lua_ls",
  "vtsls",
}

require("mason").setup({
  ui = {
    icons = {
      package_installed = "󰸞",
      package_pending = "󰜴",
      package_uninstalled = "",
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    local builtin = require('telescope.builtin')

    map('<leader>q', diagnostics_list, "Push diagnostics to quickfix list")
    map("gr", "<cmd>Telescope lsp_references<CR>", "[G]oto [R]eferences")
    map('gd', function()
      builtin.lsp_definitions({
        fname_width = 60,
        trim_text = true,
        show_line = false,
        ignore_filename = true,
        file_ignore_patterns = { "node_modules/@types/*" }
      })
    end, "[G]oto [D]efinition")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<space>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic list")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    vim.diagnostic.config({
      virtual_text = {
        source = "if_many",
        prefix = "■",
        spacing = 4,
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
    })

    local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.diagnostic.config({
        signs = {
          { name = hl, text = icon, texthl = hl }
        },
      })
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end
    if client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end
  end
})

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities()
})

vim.lsp.config("lua_ls", {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end
