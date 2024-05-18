local ts = {}

function ts.treesitter ()

    -- https://github.com/nix-community/nixvim/discussions/540#discussioncomment-6881292
    if require("core.nixCatsUtils").isNixCats then
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.nu = {
            install_info = {},
            filetype = "nu",
        }
    end
    require("nvim-treesitter.configs").setup({
        ensure_installed = require("core.nixCatsUtils").ifNixCats(nil, { "lua", "bash", "vim", "json", "latex", "python", "markdown", "ron", "rust", "toml", "vimdoc", "yaml"  }),
        autopairs = { enable = false },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true
        },
    })

end


return ts
