local conf = require("modules.completion.config")
local debug = require("core.pack").package

debug({
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = { 
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/cmp-dap",
        "rcarriga/nvim-dap-ui"
    },
    keys = {
        {
            "<leader>bb",
            "<cmd>lua require('dap').toggle_breakpoint()<cr>",
        },
        {
            "<leader>bc",
            "<cmd>lua require('dap').continue()<cr>",
        },
        {
            "<leader>bs",
            "<cmd>lua require('dap').step_over()<cr>",
        },
        {
            "<leader>bS",
            "<cmd>lua require('dap').step_into()<cr>",
        },
    },
    config = function ()
        local sign = vim.fn.sign_define

        sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
        sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
        sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})


        local dap = require("dap")
        dap.adapters.coreclr = {
            type = 'executable',
            command = 'netcoredbg',
            args = {'--interpreter=vscode'}
        }
        vim.g.dotnet_build_project = function()
            local default_path = vim.fn.getcwd() .. '/'
            if vim.g['dotnet_last_proj_path'] ~= nil then
                default_path = vim.g['dotnet_last_proj_path']
            end
            local path = vim.fn.input('Path to your *proj file', default_path, 'file')
            vim.g['dotnet_last_proj_path'] = path
            local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
            print('')
            print('Cmd to execute: ' .. cmd)
            local f = os.execute(cmd)
            if f == 0 then
                print('\nBuild: ✔️ ')
            else
                print('\nBuild: ❌ (code: ' .. f .. ')')
            end
        end

        vim.g.dotnet_get_dll_path = function()
            local request = function()
                return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end

            if vim.g['dotnet_last_dll_path'] == nil then
                vim.g['dotnet_last_dll_path'] = request()
            else
                if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
                    vim.g['dotnet_last_dll_path'] = request()
                end
            end

            return vim.g['dotnet_last_dll_path']
        end

        local config = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
                        vim.g.dotnet_build_project()
                    end
                    return vim.g.dotnet_get_dll_path()
                end,
            },
        }

        dap.configurations.cs = config
        dap.configurations.fsharp = config
    end
})

debug({
    "rcarriga/nvim-dap-ui",
    lazy = true,
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            -- Use this to override mappings for specific elements
            element_mappings = {
                -- Example:
                -- stacks = {
                --   open = "<CR>",
                --   expand = "o",
                -- }
            },
            -- Expand lines larger than the window
            -- Requires >= 0.7
            expand_lines = vim.fn.has("nvim-0.7") == 1,
            -- Layouts define sections of the screen to place windows.
            -- The position can be "left", "right", "top" or "bottom".
            -- The size specifies the height/width depending on position. It can be an Int
            -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
            -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
            -- Elements are the elements shown in the layout (in order).
            -- Layouts are opened in order so that earlier layouts take priority in window sizing.
            layouts = {
                {
                    elements = {
                        -- Elements can be strings or table with id and size keys.
                        { id = "scopes", size = 0.25 },
                        "breakpoints",
                        "stacks",
                        "watches",
                    },
                    size = 40, -- 40 columns
                    position = "left",
                },
                {
                    elements = {
                        "repl",
                        "console",
                    },
                    size = 0.25, -- 25% of total lines
                    position = "bottom",
                },
            },
            controls = {
                -- Requires Neovim nightly (or 0.8 when released)
                enabled = true,
                -- Display controls in this element
                element = "repl",
                icons = {
                    pause = "",
                    play = "",
                    step_into = "",
                    step_over = "",
                    step_out = "",
                    step_back = "",
                    run_last = "↻",
                    terminate = "□",
                },
            },
            floating = {
                max_height = nil, -- These can be integers or a float between 0 and 1.
                max_width = nil, -- Floats will be treated as percentage of your screen.
                border = "single", -- Border style. Can be "single", "double" or "rounded"
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil, -- Can be integer or nil.
                max_value_lines = 100, -- Can be integer or nil.
            }
        })


        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

    end
})

debug({
    "theHamsta/nvim-dap-virtual-text",
    config = function()
        require("nvim-dap-virtual-text").setup({
            virt_text_pos = 'inline'
        })
    end
})

debug({
    "rcarriga/cmp-dap",
    config = function()
        require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
            sources = {
                { name = "dap" },
            },
        })
    end
})
