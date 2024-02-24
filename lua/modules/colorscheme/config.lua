local config = {}

function config.catppuccin() 
    local catppuccin = require('catppuccin')
    -- Look here for the actual color configurations.
    local colors = require('core.config.colors')
    catppuccin.setup({
        -- If `kitty = true`, the colors will be shifted by one value, making
        -- it impossible for the background to be transparent.
        -- I want the main panel to be transparent :)
        kitty = false,
        color_overrides = {
            mocha = colors.catppuccin_override
        },
        -- No reason not to really have these
        integrations = {
            harpoon = true,
            aerial = true,
            flash = true,
            noice = true,
            notify = true,
            neotree = true,
            lsp_trouble = true,
            markdown = true,
            treesitter = true,
            mason = true,
            rainbow_delimiters = true,
            telescope = { enabled = true, style = "nvchad" },
            cmp = true,
            semantic_tokens = true,
            dap = true,
            dap_ui = true,
        },
        styles = colors.catppuccin_styles,
        highlight_overrides = {
            all = colors.catppuccin_highlight_overrides
        }
    })
    vim.cmd('colorscheme catppuccin-mocha')
end

return config
