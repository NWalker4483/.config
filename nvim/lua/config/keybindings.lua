-- General Neovim keybindings (non-plugin specific)
-- These keybindings use native Vim/Neovim functionality

local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap ~= false
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Essential shortcuts
-- Ctrl+S to save
map('n', '<C-s>', '<cmd>w<cr>', { desc = "Save File" })
map('i', '<C-s>', '<Esc><cmd>w<cr>a', { desc = "Save File" })

-- Ctrl+W to close buffer/window
map('n', '<C-w>', '<cmd>q<cr>', { desc = "Close Window" })

-- Split screen commands
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Horizontal Split" })
map("n", "<leader>sc", "<cmd>close<cr>", { desc = "Close Split" })
map("n", "<leader>so", "<cmd>only<cr>", { desc = "Close Other Splits" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Window resizing
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Tab management
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next Tab" })

-- Buffer navigation
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Terminal mode keybindings (native functionality)
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })

-- Additional useful general keybindings
-- Quick save
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })

-- Quick quit
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Clear search highlighting
map("n", "<leader>/", "<cmd>noh<cr>", { desc = "Clear Search Highlight" })

-- Better up/down movement for wrapped lines
map({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Lines Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Lines Up" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', { desc = "Paste Without Yank" })

-- Which-key group definitions for general functionality
if pcall(require, "which-key") then
    require("which-key").register({
        ["<leader>s"] = { name = "Split" },
        ["<leader>t"] = { name = "Tabs/Terminal" },
        ["<leader>u"] = { name = "UI Toggle" },
    })
end