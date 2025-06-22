return {
    -- CSV Viewing with auto-enable
{
  "hat0uma/csvview.nvim",
  config = function()
    require("csvview").setup({
      parser = {
        delimiter = {
          default = ",",
          ft = {
            tsv = "\t",
          },
        },
        comments = { "#", "//" },
      },
      view = {
        display_mode = "border", -- "highlight" | "border"
        min_column_width = 5,
        spacing = 2,
      },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    })
    
    -- Auto-enable CSV view when opening CSV/TSV files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "csv", "tsv" },
      callback = function()
        require("csvview").enable()
      end,
    })
  end,
  ft = { "csv", "tsv" },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
},

  -- Modern Markdown Previewer (separate plugin)
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Important: should not be lazy loaded
    ft = { "markdown", "html",  "typst", "yaml" },
    config = function()
      -- Run :TSInstall markdown markdown_inline html latex typst yaml
      -- if parsers are missing
      require("markview").setup({
        modes = { "n", "no", "c" },
        hybrid_modes = { "n" },
        
        callbacks = {
          on_enable = function (_, win)
            vim.wo[win].conceallevel = 2;
            vim.wo[win].concealcursor = "c";
          end
        },
      })
      
      -- Load checkbox functionality
      require("markview.extras.checkboxes").setup()
    end,
    keys = {
      { "<leader>mv", "<cmd>Markview toggle<cr>", desc = "Toggle Markview" },
      { "<leader>mh", "<cmd>Markview hybridToggle<cr>", desc = "Toggle Hybrid Mode" },
      { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Toggle Split View" },
      { "<leader>mc", "<cmd>Checkbox toggle<cr>", desc = "Toggle Checkbox" },
    },
  },

}