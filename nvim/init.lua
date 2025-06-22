require('config.lazy')
-- vim.lsp.enable('pyright')
-- Auto-change to directory when opening a directory argument
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local args = vim.fn.argv()
    if #args == 1 and vim.fn.isdirectory(args[1]) == 1 then
      -- Change Neovim's working directory to the opened directory
      vim.cmd("cd " .. vim.fn.fnamemodify(args[1], ":p"))
    end
  end,
})

-- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
-- 1
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    -- 2
    vim.api.nvim_create_autocmd("BufWritePre", {
      -- 3
      buffer = args.buf,
      callback = function()
        -- 4 + 5
        vim.lsp.buf.format {async = false, id = args.data.client_id }
      end,
    })
  end
})

