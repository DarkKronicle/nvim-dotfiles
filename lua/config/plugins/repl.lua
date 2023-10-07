return {
    {
        'Vigemus/iron.nvim',
        lazy = true,
        config = function ()
            local view = require("iron.view")
            local iron = require("iron.core")

            iron.setup({
                config = {
                    repl_definition = {
                        qalc = {
                            command = {"qalc"},
                        }
                    },
                    repl_open_cmd = view.split.vertical(30)
                },
                keymaps = {
                    send_motion = "<leader>sc",
                    visual_send = "<leader>sc",
                    send_file = "<leader>sf",
                    send_line = "<leader><cr>",
                    send_until_cursor = "<leader>su",
                    send_mark = "<leader>sm",
                    mark_motion = "<leader>mc",
                    mark_visual = "<leader>mc",
                    remove_mark = "<leader>md",
                    cr = "<leader>s<cr>",
                    interrupt = "<leader>s<leader>",
                    exit = "<leader>sq",
                    clear = "<leader>cl",
                },
                ignore_blank_lines = true,
            })

            vim.api.nvim_create_user_command('Qalc', function (_)
                vim.cmd('IronRepl qalc')
                vim.cmd('IronAttach qalc')
            end, {})
        end
    },
    {
        'lervag/vimtex',
        lazy = false,
        config = function ()
            vim.g.vimtex_matchparen_enabled = false
            vim.g.vimtex_fold_manual        = true
        end
    },
}
