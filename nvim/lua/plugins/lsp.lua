local diagnostics_list = require("utils").diagnostics_list

return {
  "mason-org/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    'saghen/blink.cmp',
    -- "hrsh7th/cmp-nvim-lsp",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local mason = require("mason")
    local blink_cmp = require("blink.cmp")
    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local builtin = require('telescope.builtin')
    mason.setup()

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map('<leader>q', diagnostics_list, "Push disgnostics to quickfix list")
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
              { name = hl, text = icon, texthl = hl } -- numhl is not needed in the new API
            },
          })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end
        if (client.name == "eslint" or client.name == "ts_ls") then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
        if client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
          -- Highlight word under cursor in entire file
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          -- remove highlight on cursor move
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
            end,
          })
        end
      end
    })

    vim.lsp.config("*", {
      capabilities = blink_cmp.get_lsp_capabilities()
      -- capabilities = cmp_nvim_lsp.default_capabilities()
    })

    -- enable LSP servers
    vim.lsp.enable("astro")
    vim.lsp.enable("clangd")
    vim.lsp.enable("cssls")
    vim.lsp.enable("eslint")
    -- vim.lsp.enable("gopls")
    vim.lsp.enable("html")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("rust_analyzer")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("ts_ls")
  end
}
