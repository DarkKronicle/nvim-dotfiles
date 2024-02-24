local config = {}

function config.neotree()
    local neotree = require('neo-tree')
    neotree.setup({
        close_if_last_window = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true
        },
        default_component_configs = {
            icon = {
                folder_closed = "",
                folder_open = "",
            }
        },
        window = {
            width = 30
        },
        open_files_do_not_replace_types = { "edgy" },
    })
end

function config.heirline()
    local heirline = require('heirline')
    local heirline_components = require("heirline-components.all")
    local heirline_modules = require('modules.ui.heirline')
    local lib = require('heirline-components.all')
    heirline_components.init.subscribe_to_events()
    heirline.load_colors(heirline_components.hl.get_colors())
    heirline.setup({
        opts = {
            disable_winbar_cb = function(args) -- make the breadcrumbs bar inactive when...
                local is_disabled = lib.condition.buffer_matches({
                    buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
                    filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
                }, args.buf)
                return is_disabled
            end,
        },
        tabline = heirline_modules.tabline(), -- UI upper bar
        statuscolumn = heirline_modules.statuscolumn(),
        statusline = heirline_modules.statusline(),
        -- winbar = heirline_modules.winbar(),
    })
end


return config
