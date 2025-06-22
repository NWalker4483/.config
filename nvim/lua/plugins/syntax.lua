return { -- Treesitter for syntax highlighting (separate plugin)
{
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {"OXY2DEV/markview.nvim"}, -- Ensure markview loads first
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { -- Core
            'lua', 'vim', 'vimdoc', 'query', -- Web
            'html', 'css', 'javascript', 'typescript', 'tsx', 'json', 'yaml', 'toml', -- Documents & markup
            'markdown', 'markdown_inline', 'typst', -- Programming languages  
            'regex', 'bash', 'python', 'rust', 'go', 'c', 'cpp', -- Frontend frameworks
            'svelte', 'vue', 'scss', -- CSV and other data formats
            'csv'},
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
            indent = {
                enable = true
            }
        })
    end
}, -- Optional: Icons support
{
    "nvim-tree/nvim-web-devicons",
    lazy = true
}, -- Optional: which-key for toggle 
{
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup()
    end
}}
