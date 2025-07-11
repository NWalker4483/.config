return { -- Snacks.nvim - Collection of QoL plugins
{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- Core snacks features
        bigfile = {
            enabled = true
        },
        dashboard = {
            enabled = true,
            sections = {{
                section = "header"
            }, {
                section = "keys",
                gap = 1,
                padding = 1
            }, {
                section = "startup"
            }}
        },
        indent = {
            enabled = true
        },
        input = {
            enabled = true
        },
        notifier = {
            enabled = true
        },
        quickfile = {
            enabled = true
        },
        image = {
            enabled = true
        },
        scope= {
            enabled = true
        },scroll = {
            enabled = true
        },
        statuscolumn = {
            enabled = true
        },
        words = {
            enabled = true
        },
        zen = {
            enabled = true
        },
        bufdelete = {
            enabled = true
        },
        rename = {
            enabled = true
        },
        lazygit = {
            enabled = true
        },
        git = {
            enabled = true
        },
        gitbrowse = {
            enabled = true
        },

        -- Explorer with enhanced configuration
        explorer = {
            enabled = true,
            -- Show hidden files (dotfiles)
            show_hidden = true,
            -- Auto-expand to current file
            auto_expand = true,
            -- Additional useful options
            follow = true, -- Follow the current file
            win = {
                width = 30, -- Set explorer width
                position = "left"
            }
        },

        picker = {
            enabled = true,
            hidden = true,
            ignored = true
        },
        toggle = {
            enabled = true
        },
        scratch = {
            enabled = true
        },
        animate = {
            enabled = true
        },

        -- Terminal
        terminal = {
            enabled = true,
            -- Configure default terminal layout
            win = {
                style = "terminal",
                position = "bottom", -- Default to bottom position
                height = 0.3, -- 30% of screen height
                width = 0.9, -- 90% of screen width when floating
                border = "rounded"
            }
        }
    },
    keys = { 
        -- File Management
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "Explorer"
        }, 
        --   { "<leader>E", function() Snacks.explorer({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Explorer (cwd)" },
        
        -- Git Integration
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit"
        }, 
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame Line"
        }, 
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse"
        }, 
        {
            "<leader>gf",
            function()
                Snacks.lazygit.log_file()
            end,
            desc = "Lazygit Current File History"
        }, 
        {
            "<leader>gl",
            function()
                Snacks.lazygit.log()
            end,
            desc = "Lazygit Log (cwd)"
        }, 
        
        -- File Operations
        {
            "<leader>r",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename File"
        }, 
        
        -- Finder/Picker
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files"
        }, 
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Live Grep"
        }, 
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Find Buffers"
        }, 
        {
            "<leader>fh",
            function()
                Snacks.picker.help()
            end,
            desc = "Find Help"
        }, 
        {
            "<leader>fr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent Files"
        }, 
        {
            "<leader>fc",
            function()
                Snacks.picker.commands()
            end,
            desc = "Commands"
        }, 
        {
            "<leader>fk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Key Maps"
        }, 
        
        -- Words (references/navigation)
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            mode = {"n", "t"}
        }, 
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            mode = {"n", "t"}
        }, 
        
        -- Utilities
        {
            "<leader>z",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode"
        }, 
        {
            "<leader>n",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Notification History"
        }, 
        {
            "<leader>bd",
            function()
                Snacks.bufdelete()
            end,
            desc = "Delete Buffer"
        }, 
        
        -- Terminal shortcuts (Snacks-specific)
        {
            "<c-/>",
            function()
                Snacks.terminal()
            end,
            desc = "Toggle Terminal"
        }, 
        {
            "<c-_>",
            function()
                Snacks.terminal()
            end,
            desc = "Toggle Terminal (which_key_ignore)"
        }, 
        {
            "<leader>tt",
            function()
                Snacks.terminal()
            end,
            desc = "Toggle Terminal"
        }, 
        {
            "<leader>tf",
            function()
                Snacks.terminal(nil, {
                    win = {
                        position = "float"
                    }
                })
            end,
            desc = "Terminal Float"
        }, 
        {
            "<leader>th",
            function()
                Snacks.terminal(nil, {
                    win = {
                        position = "bottom",
                        height = 0.3
                    }
                })
            end,
            desc = "Terminal Horizontal"
        }, 
        {
            "<leader>tv",
            function()
                Snacks.terminal(nil, {
                    win = {
                        position = "right",
                        width = 0.4
                    }
                })
            end,
            desc = "Terminal Vertical"
        }, 
        {
            "<leader>ts",
            function()
                -- Split current terminal
                Snacks.terminal(nil, {
                    win = {
                        position = "bottom",
                        height = 0.3
                    }
                })
            end,
            desc = "Terminal Split"
        },
        
        -- Terminal mode Snacks shortcuts
        {
            "<C-/>",
            function()
                Snacks.terminal()
            end,
            desc = "Toggle Terminal",
            mode = "t"
        },
        
        -- Group definitions for Snacks features
        {
            "<leader>f",
            group = "Find"
        }, 
        {
            "<leader>g",
            group = "Git"
        }
    }
}}