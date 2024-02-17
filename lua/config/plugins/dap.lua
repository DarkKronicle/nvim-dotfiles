return {
    {
        'mfussenegger/nvim-dap',
        event = 'VeryLazy',
        keys = {
            {
                '<leader>b',
                function ()
                    require('dap').toggle_breakpoint()
                end,
                desc = "Toggle Breakpoint"
            },
            {
                '<F1>',
                function ()
                    require('dap').continue()
                end,
                desc = "Continue execution"
            },
            {
                '<F2>',
                function ()
                    require('dap').step_over()
                end,
                desc = "Step into"
            },
            {
                '<F3>',
                function ()
                    require('dap').step_into()
                end,
                desc = "Step out",
            }
        },
        config = function ()
            local dap = require('dap')
            dap.adapters.codelldb = {
                type = 'server',
                port = "${port}",
                executable = {
                    command = '/usr/bin/codelldb',
                    args = {"--port", "${port}"},
                }
            }
            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }
            dap.configurations.rust = dap.configurations.cpp
        end
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        event = 'VeryLazy',
        config = function()
            require("nvim-dap-virtual-text").setup({
                enabled_commands = true,
            })
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            {
                '<leader>du',
                function()
                    require('dapui').toggle()
                end,
                desc = "Dap UI"
            },
        },
        event = 'VeryLazy',
        config = function() 
            require('dapui').setup({
                layouts = { {
                    elements = { {
                        id = "scopes",
                        size = 0.25
                    }, {
                        id = "breakpoints",
                        size = 0.25
                    }, {
                        id = "stacks",
                        size = 0.25
                    }, {
                        id = "watches",
                        size = 0.25
                    } },
                    position = "left",
                    size = 40
                }, {
                    elements = { {
                        id = "console",
                        size =1 
                    } },
                    position = "right",
                    size = 60
                } },
            })
        end
    }
}
