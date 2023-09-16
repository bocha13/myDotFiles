return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local get_root = require("utils").get_root

    -- set keymaps
    local keymap = vim.keymap
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local root_dir = get_root()

      -- disable tsserver formatting for learner-frontend project
      if string.find(root_dir, "learner%-frontend") ~= nil then
        if client.name == "eslint" then
          client.server_capabilities.documentFormattingProvider = true
        elseif client.name == "tsserver" then
          client.server_capabilities.documentFormattingProvider = false
        end
      end

      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap.set("n", "<space>cd", vim.diagnostic.open_float, opts)
    end

    -- used to enable autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- default config for all servers
    local defaultOpts = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- add servers to this list and they will be automatically setup
    local serverList = {
      ["html"] = defaultOpts,
      ["cssls"] = defaultOpts,
      ["graphql"] = defaultOpts,
      ["tsserver"] = defaultOpts,
      ["tailwindcss"] = defaultOpts,
      ["rust_analyzer"] = defaultOpts,
      ["eslint"] = defaultOpts,
      ["jsonls"] = defaultOpts,
      ["lua_ls"] = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "general" }
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              }
            }
          }
        }
      }
    }

    for server, config in pairs(serverList) do
      lspconfig[server].setup(config)
    end
  end
}
