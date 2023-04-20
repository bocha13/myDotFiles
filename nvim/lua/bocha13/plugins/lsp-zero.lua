return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        sugestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup({
        formatters = {
          label = require("copilot_cmp.format").format_label_text,
          preview = require("copilot_cmp.format").deindent,
          insert_text = require("copilot_cmp.format").remove_existing,
        },
      })
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.vmd, "MasonUpdate")
        end,
      },                                       -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },         -- Required
      { "hrsh7th/cmp-nvim-lsp" },     -- Required
      { "hrsh7th/cmp-buffer" },       -- Optional
      { "hrsh7th/cmp-path" },         -- Optional
      { "saadparwaiz1/cmp_luasnip" }, -- Optional
      { "hrsh7th/cmp-nvim-lua" },     -- Optional

      -- Snippets
      { "L3MON4D3/LuaSnip" },             -- Required
      { "rafamadriz/friendly-snippets" }, -- Optional
    },
    config = function()
      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local lsp = require("lsp-zero").preset({
        name = "minimal",
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
      })
      lsp.setup_servers({
        "tsserver",
        "eslint",
        "rust_analyzer",
        "tailwindcss",
        "lua_ls",
      })

      lsp.setup_nvim_cmp({
        preselect = "none",
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        mapping = lsp.defaults.cmp_mappings({
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
        }),
        sources = {
          { name = "copilot" },
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "buffer",  keyword_length = 3 },
          { name = "luasnip", keyword_length = 2 },
        },
      })

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
        return string.match(value.filename, 'react/index.d.ts') == nil
      end

      local function on_list(options)
        local items = options.items
        if #items > 1 then
          items = filter(items, filterReactDTS)
        end

        vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
        vim.api.nvim_command('cfirst') -- or maybe you want 'copen' instead of 'cfirst'
      end

      lsp.on_attach(function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition { on_list = on_list } end, bufopts)
      end)

      lsp.nvim_workspace()
      lsp.setup()

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
}
