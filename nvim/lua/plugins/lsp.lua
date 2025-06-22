return { -- Completion engine
{
    "hrsh7th/nvim-cmp",
    dependencies = {"hrsh7th/cmp-nvim-lsp", -- LSP source
    "hrsh7th/cmp-buffer", -- Buffer source
    "hrsh7th/cmp-path", -- File path source
    "hrsh7th/cmp-cmdline", -- Command line source
    "L3MON4D3/LuaSnip", -- Snippet engine
    "saadparwaiz1/cmp_luasnip" -- Snippet source
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({
                    select = true
                }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {'i', 's'}),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'})
            }),
            sources = cmp.config.sources({{
                name = 'nvim_lsp'
            }, {
                name = 'luasnip'
            }}, {{
                name = 'buffer'
            }, {
                name = 'path'
            }})
        })
    end
}, {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {"pyright", -- Python LSP
        "rust_analyzer", -- Rust LSP
        "lua_ls" -- Lua LSP (for nvim config)
        },
        automatic_installation = true
    },
    dependencies = {{
        "mason-org/mason.nvim",
        opts = {}
    }, "neovim/nvim-lspconfig"},
    config = function(_, opts)
        require("mason-lspconfig").setup(opts)

        -- LSP keybindings function
        local on_attach = function(client, bufnr)
            local bufopts = {
                noremap = true,
                silent = true,
                buffer = bufnr
            }

            -- Navigation
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)

            -- Documentation
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

            -- Code actions
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format {
                    async = true
                }
            end, bufopts)

            -- Diagnostics
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, bufopts)

            -- Workspace
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
        end

        -- Setup LSP servers with keybindings
        local lspconfig = require('lspconfig')

        -- Add completion capabilities
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Python
        lspconfig.pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }

        -- Rust
        lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ['rust-analyzer'] = {
                    checkOnSave = {
                        command = 'clippy'
                    }
                }
            }
        }

        -- Lua
        lspconfig.lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    diagnostics = {
                        globals = {'vim'}
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true)
                    },
                    telemetry = {
                        enable = false
                    }
                }
            }
        }
    end
}}
