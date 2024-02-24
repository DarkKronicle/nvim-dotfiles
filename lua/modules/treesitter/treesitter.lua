local ts = {}

function ts.treesitter ()

    require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "bash", "vim", "json", "latex", "python", "markdown", "ron", "rust", "toml", "vimdoc", "yaml"  },
        autopairs = { enable = false },
        highlight = {
            enable = true,
        },
    })

end


return ts
