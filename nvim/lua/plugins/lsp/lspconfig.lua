local diagnostics_list = require("utils").diagnostics_list

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- 'saghen/blink.cmp',
    "hrsh7th/cmp-nvim-lsp",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    -- local blink_cmp = require("blink.cmp")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local builtin = require('telescope.builtin')

    -- set keymaps
    local keymap = vim.keymap
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.lsp.inlay_hint.enable(true)

      keymap.set('n', '<leader>q', diagnostics_list, { noremap = true, silent = true })
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      -- keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      keymap.set('n', 'gd', function()
        builtin.lsp_definitions({
          fname_width = 60,
          trim_text = true,
          show_line = false,
          ignore_filename = true,
          file_ignore_patterns = { "node_modules/@types/*" }
        })
      end, { desc = 'Goto Definition' })
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      keymap.set("n", "gr", vim.lsp.buf.references, opts)
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap.set("n", "<space>cd", vim.diagnostic.open_float, opts)

      if (client.name == "eslint" or client.name == "ts_ls") then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end

    vim.diagnostic.config({
      -- Enable virtual text
      virtual_text = {
        source = "if_many",
        prefix = "■",
        spacing = 4,
      },
      -- Other diagnostic options...
      update_in_insert = false,
      underline = true,
      severity_sort = true,
    })

    -- used to enable autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.diagnostic.config({
        signs = {
          { name = hl, text = icon, texthl = hl } -- numhl is not needed in the new API
        },
      })
    end


    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = {
        "astro",
        "html",
        "cssls",
        "graphql",
        "rust_analyzer",
        "tailwindcss",
        "ts_ls",
        "gopls",
        "clangd",
        "eslint",
        "jsonls",
        "lua_ls",
      },
      automatic_enable = false
    })

    -- attach config to each lsp
    for _, server_name in pairs(mason_lspconfig.get_installed_servers()) do
      if server_name == "cssls" then
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore"
              },
              modules = true -- Enable CSS modules
            }
          }
        })
      elseif server_name == "lua_ls" then
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        })
      else
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end
  end,
}
