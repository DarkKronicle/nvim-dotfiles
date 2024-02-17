return {
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        config = function ()
            require("toggleterm").setup({
                open_mapping = [[<c-\>]],
                direction = "float",
                shade_terminals = true,
                float_opts = {
                    border = "curved",
                },
            })
        end
    },
}
