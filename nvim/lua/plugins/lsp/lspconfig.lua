local diagnostics_list = require("utils").diagnostics_list

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- set keymaps
    local keymap = vim.keymap
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.lsp.inlay_hint.enable(true)

      keymap.set('n', '<leader>q', diagnostics_list,
        { noremap = true, silent = true })
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      keymap.set("n", "gr", vim.lsp.buf.references, opts)
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
      ["astro"] = defaultOpts,
      ["html"] = defaultOpts,
      ["cssls"] = defaultOpts,
      ["graphql"] = defaultOpts,
      ["ts_ls"] = defaultOpts,
      ["tailwindcss"] = defaultOpts,
      ["gopls"] = defaultOpts,
      ["clangd"] = {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "clangd", "--clang-tidy", "--completion-style=detailed" }, -- Adjust flags as needed
      },
      ["rust_analyzer"] = {
        on_attach = on_attach,
        capabilities = capabilities,
        inlayHints = {
          typeHints = true,
          parameterHints = true,
          chainingHints = true,
          enable = true,
          showParameterNames = true,
          parameterHintsPrefix = "<- ",
          otherHintsPrefix = "=> ",
        },
        checkOnSave = {
          command = "clippy",
          allFeatures = true,
          extraArgs = { "--no-deps" },
        },
        cargo = {
          loadOutDirsFromCheck = true,
          allTargets = true, -- Try setting this to true if needed
        },
        procMacro = {
          enable = true,
        },
      },
      ["eslint"] = defaultOpts,
      ["jsonls"] = defaultOpts,
      ["lua_ls"] = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "general" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      },
    }

    for server, config in pairs(serverList) do
      lspconfig[server].setup(config)
    end

    -- tsserver setup with formatting disabled
    lspconfig.ts_ls.setup({
      on_attach = function(client, _)
        -- Disable tsserver formatting
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    })

    -- eslint setup with formatting disabled
    lspconfig.eslint.setup({
      on_attach = function(client, _)
        -- Disable eslint formatting
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    })
  end,
}
