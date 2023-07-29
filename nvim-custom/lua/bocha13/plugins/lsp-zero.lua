return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      sugestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    event = "BufReadPre",
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    lazy = true,
    config = function()
      require("lsp-zero.settings").preset({})
      -- diagnostic configs
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        float = {
          style = "minimal",
          border = "none",
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        lazy = true,
      },
      {
        "hrsh7th/cmp-path",
        lazy = true,
      },
      {
        "saadparwaiz1/cmp_luasnip",
        lazy = true,
      },
    },
    event = "InsertEnter",
    config = function()
      -- require("lsp-zero.cmp").extend()
      require("bocha13.icons")

      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        preselect = "none",
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        sources = {
          { name = "copilot" },
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "buffer",  keyword_length = 3 },
          { name = "luasnip", keyword_length = 2 },
        },
        formatting = {
          format = function(_, item)
            if Icons[item.kind] then
              item.kind = Icons[item.kind] .. item.kind
            end
            return item
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate"
      },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp = require("lsp-zero").preset({})

      lsp.setup_servers({
        "tsserver",
        "eslint",
        "rust_analyzer",
        "lua_ls",
      })

      -- this following bunch of code is to filter out react/.index.d.ts from the definition list
      -- because it's annoying to have to scroll through them
      local function filter(arr, fn)
        if type(arr) ~= "table" then
          return arr
        end

        local filtered = {}
        for k, v in pairs(arr) do
          if fn(v, k, arr) then
            table.insert(filtered, v)
          end
        end

        return filtered
      end

      local function filterReactDTS(value)
        return string.match(value.filename, "react/index.d.ts") == nil
      end

      local function on_list(options)
        local items = options.items
        if #items > 1 then
          items = filter(items, filterReactDTS)
        end

        vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
        vim.api.nvim_command("cfirst") -- or maybe you want 'copen' instead of 'cfirst'
      end

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition({ on_list = on_list })
        end, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<space>cd", vim.diagnostic.open_float, bufopts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<leader>fA", "<cmd>EslintFixAll<CR>", bufopts)
        vim.keymap.set("n", "<space>fa", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
      end)

      -- (Optional) Configure lua language server for neovim
      require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()
    end,
  },
}
