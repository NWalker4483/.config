return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {ensure_installed = {
          "pyright",          -- Python LSP
          "rust_analyzer",  -- Rust LSP
          "lua_ls",         -- Lua LSP (for nvim config)
        },
        automatic_installation = true,},
    dependencies = {
        {
          "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}}
