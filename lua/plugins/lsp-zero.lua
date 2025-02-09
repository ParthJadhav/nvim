-- return {
--   {
--     "VonHeikemen/lsp-zero.nvim",
--     branch = "v3.x",
--     lazy = true,
--     config = false,
--     init = function()
--       -- Disable automatic setup, we are doing it manually
--       vim.g.lsp_zero_extend_cmp = 0
--       vim.g.lsp_zero_extend_lspconfig = 0
--     end,
--   },
--   {
--     "williamboman/mason.nvim",
--     lazy = false,
--     config = true,
--   },

--   -- Autocompletion
--   {
--     "hrsh7th/nvim-cmp",
--     event = "InsertEnter",
--     dependencies = {
--       {
--         "L3MON4D3/LuaSnip",
--       },
--     },
--     config = function()
--       -- Here is where you configure the autocompletion settings.
--       local lsp_zero = require("lsp-zero")
--       lsp_zero.extend_cmp()

--       -- And you can configure cmp even more, if you want to.
--       local cmp = require("cmp")
--       local cmp_action = lsp_zero.cmp_action()

--       cmp.setup({
--         formatting = lsp_zero.cmp_format(),
--         mapping = cmp.mapping.preset.insert({
--           ["<Tab>"] = cmp_action.luasnip_supertab(),
--           ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
--           ["<CR>"] = cmp.mapping.confirm({ select = false }),
--           ["<C-Space>"] = cmp.mapping.complete(),
--           ["<C-u>"] = cmp.mapping.scroll_docs(-4),
--           ["<C-d>"] = cmp.mapping.scroll_docs(4),
--           ["<C-f>"] = cmp_action.luasnip_jump_forward(),
--           ["<C-b>"] = cmp_action.luasnip_jump_backward(),
--         }),
--         window = {
--           completion = cmp.config.window.bordered(),
--           documentation = cmp.config.window.bordered(),
--         },
--         sources = {
--           { name = "copilot" },
--           { name = "nvim_lsp" },
--           { name = "nvim_lua" },
--           { name = "luasnip" },
--           { name = "buffer" },
--           { name = "path" },
--           { name = "calc" },
--           { name = "emoji" },
--           { name = "treesitter" },
--           { name = "crates" },
--           { name = "tmux" },
--         },
--         snippet = {
--           expand = function(args)
--             require("luasnip").lsp_expand(args.body)
--           end,
--         },
--       })
--     end,
--   },

--   -- LSP
--   {
--     "neovim/nvim-lspconfig",
--     cmd = { "LspInfo", "LspInstall", "LspStart" },
--     event = { "BufReadPre", "BufNewFile" },
--     dependencies = {
--       { "hrsh7th/cmp-nvim-lsp" },
--       { "williamboman/mason-lspconfig.nvim" },
--       { "b0o/schemastore.nvim" },
--     },
--     config = function()
--       local lsp_zero = require("lsp-zero")
--       lsp_zero.extend_lspconfig()

--       lsp_zero.on_attach(function(client, bufnr)
--         lsp_zero.default_keymaps({ buffer = bufnr })
--         opts = { buffer = bufnr, silent = true }

--         if vim.bo.filetype == "rust" then
--           vim.keymap.set("n", "K", "<cmd>RustLsp hover actions<CR>", opts)
--         else
--           vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
--         end

--         -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
--         vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
--         vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
--         vim.keymap.set("n", "gi", ":Telescope lsp_implementations<cr>", opts)
--         vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
--         vim.keymap.set("n", "gr", ":Telescope lsp_references<cr>", opts)
--         vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
--         vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
--         vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
--         vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

--         vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
--         vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
--         vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
--       end)

--       local lspconfig = require("lspconfig")

--       require("lspconfig.ui.windows").default_options.border = "single"

--       require("mason").setup({
--         ui = {
--           border = "rounded",
--         },
--       })
--       require("mason-lspconfig").setup({
--         ensure_installed = {
--           -- 'tsserver',
--           -- "eslint",
--           -- 'rust_analyzer',
--           "gopls",
--           "lua_ls",
--           "jsonls",
--           "bashls",
--           "vimls",
--           "terraform_ls",
--         },
--         handlers = {
--           lsp_zero.default_setup,
--           lua_ls = function()
--             local lua_opts = lsp_zero.nvim_lua_ls()
--             lspconfig.lua_ls.setup(lua_opts)
--           end,

--           lspconfig.solidity.setup({
--             cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
--             filetypes = { "solidity", "sol" },
--             root_dir = require("lspconfig.util").find_git_ancestor,
--             single_file_support = true,
--           }),

--           lspconfig.jsonls.setup({
--             settings = {
--               json = {
--                 schema = require("schemastore").json.schemas(),
--                 validate = { enable = true },
--               },
--             },
--           }),

--           lspconfig.gopls.setup(require("go.lsp").config()),

--           lspconfig.terraformls.setup({
--             cmd = { "terraform-ls", "serve" },
--             filetypes = { "terraform", "tf", "terraform-vars" },
--             root_dir = lspconfig.util.root_pattern("*.tf", "*.terraform", "*.tfvars", "*.hcl", "*.config"),
--           }),
--         },
--       })

--       lsp_zero.set_preferences({
--         suggest_lsp_servers = false,
--       })

--       lsp_zero.set_sign_icons({
--         error = "E",
--         warn = "W",
--         hint = "H",
--         info = "I",
--       })

--       vim.diagnostic.config({
--         title = false,
--         underline = true,
--         virtual_text = true,
--         signs = true,
--         update_in_insert = false,
--         severity_sort = true,
--         float = {
--           source = "always",
--           style = "minimal",
--           border = "rounded",
--           header = "",
--           prefix = "",
--         },
--       })
--     end,
--   },
-- }

return {}