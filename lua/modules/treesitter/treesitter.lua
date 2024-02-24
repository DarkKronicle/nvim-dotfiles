local ts = {}

function ts.treesitter ()

    require("nvim-treesitter.configs").setup({
        autopairs = { enable = false },
        highlight = {
            enable = true,
        },
    })

end


return ts
