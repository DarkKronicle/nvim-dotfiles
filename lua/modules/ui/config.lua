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

config.smartsplits_keys = {
    {
        '<C-h>',
        function ()
            require('smart-splits').move_cursor_left()
        end,
        desc = 'Smart Splits Move Cursor Left',
    },
    {
        '<C-l>',
        function ()
            require('smart-splits').move_cursor_right()
        end,
        desc = 'Smart Splits Move Cursor Right',
    },
    {
        '<C-j>',
        function ()
            require('smart-splits').move_cursor_down()
        end,
        desc = 'Smart Splits Move Cursor Down',
    },
    {
        '<C-k>',
        function ()
            require('smart-splits').move_cursor_up()
        end,
        desc = 'Smart Splits Move Cursor Up',
    },
    {
        '<C-S-h>',
        function ()
            require('smart-splits').resize_left()
        end,
        desc = 'Smart Splits Resize Left',
    },
    {
        '<C-S-l>',
        function ()
            require('smart-splits').resize_right()
        end,
        desc = 'Smart Splits Resize Right',
    },
    {
        '<C-S-j>',
        function ()
            require('smart-splits').resize_down()
        end,
        desc = 'Smart Splits Resize Down',
    },
    {
        '<C-S-k>',
        function ()
            require('smart-splits').resize_up()
        end,
        desc = 'Smart Splits Resize Up',
    },
}

function config.animate()
    local animate = require('mini.animate')
    -- http://www.lazyvim.org/extras/ui/mini-animate
    local mouse_scrolled = false
    for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
            mouse_scrolled = true
            return key
        end, { expr = true })
    end


    animate.setup({
        cursor = {
            enable = true,
            timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
            path = animate.gen_path.line({
                predicate = function(destination)
                    -- Destination is a tuple of Δx, Δy
                    return destination[1] < -7 or 7 < destination[1]
                end
            }),
        },
        open = {
            enable = false,
        },
        close = {
            enable = false,
        },
        scroll = {
            timing = animate.gen_timing.linear({ duration = 200, unit = "total" }),
            subscroll = animate.gen_subscroll.equal({
                predicate = function(total_scroll)
                    if mouse_scrolled then
                        mouse_scrolled = false
                        return false
                    end
                    -- TODO: make this scrolloff dependent
                    -- return total_scroll > vim.opt.scrolloff and total_scroll > 3
                    return total_scroll > 8
                end,
            })
        }
    })
end

return config
