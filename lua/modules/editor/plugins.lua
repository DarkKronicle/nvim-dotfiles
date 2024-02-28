local conf = require("modules.editor.config")
local editor = require("core.pack").package


editor({
    'gbprod/cutlass.nvim',
    lazy = false,
    opts = {},
    keys = {
        {
            'q',
            'd',
            desc = 'cut',
            mode = { 'v', 'n' },
            remap = false
        },
        {
            'qq',
            'd_',
            desc = 'cut current line',
            remap = false
        }
    }
})

editor({
    "gbprod/yanky.nvim",
    keys = {
        {
            'p',
            '<Plug>(YankyPutAfter)',
            mode = { 'n', 'x' },
            desc = 'Paste after',
        },
        {
            'P',
            '<Plug>(YankyPutBefore)',
            mode = { 'n', 'x' },
            desc = 'Paste before',
        },
        {
            'gp',
            '<Plug>(YankyGPutAfter)',
            mode = { 'n', 'x' },
            desc = 'Paste G after',
        },
        {
            'gP',
            '<Plug>(YankyGPutBefore)',
            mode = { 'n', 'x' },
            desc = 'Paste G before',
        },
        {
            '[p',
            '<Plug>(YankyPreviousEntry)',
            mode = { 'n', 'x' },
            desc = 'Previous clipboard entry',
        },
        {
            ']p',
            '<Plug>(YankyNextEntry)',
            mode = { 'n', 'x' },
            desc = 'Next clipboard entry',
        },
    },
    opts = {
        system_clipboard = {
            sync_with_ring = false,
        },
        highlight = {
            on_put = true,
            on_yank = true,
            timer = 200,
        },
    }
})

-- TODO: Integrate with theme
editor({
    'jiaoshijie/undotree',
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
        {
            '<leader>u', 
            function ()
                require('undotree').toggle()
            end,
            mode = 'n',
            desc = 'Toggle undotree'
        },
    },
    opts = {
        position = 'right',
    },
})

editor({
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
})

editor({
    "KaitlynEthylia/TreePin",
    requires = {'nvim-treesitter/nvim-treesitter'},
    keys = {
        -- TODO: Hydra
        {
            "<leader>cp",
            function ()
                require('treepin').pinLocal()
            end,
            desc = 'Pin local'
        },
        {
            "<leader>cr",
            function ()
                require('treepin').pinRoot()
            end,
            desc = 'Pin root'
        },
        {
            "<leader>cx",
            function ()
                require('treepin').pinClear()
            end,
            desc = 'Pin clear'
        },
        {
            "<leader>c]",
            function ()
                require('treepin').pinGrow()
            end,
            desc = 'Pin grow'
        },
        {
            "<leader>c[",
            function ()
                require('treepin').pinShrink()
            end,
            desc = 'Pin shrink'
        },
    },
    opts = {
        separator = "─"
    }
})

-- Woah this is awesome
editor({
    'jghauser/fold-cycle.nvim',
    opts = {},
    keys = {
        {
            '<Tab>',
            function ()
                require('fold-cycle').open()
            end,
            mode = 'n',
        },
        {
            '<S-Tab>',
            function ()
                require('fold-cycle').close()
            end,
            mode = 'n',
        },
    }
})

editor({
    'kevinhwang91/nvim-ufo',
    lazy = false,
    dependencies = 'kevinhwang91/promise-async',
    -- https://github.com/vsedov/nvim/blob/5c72b68d7fbcb8b047060d7f0f417bdd533b5f54/lua/modules/ui/config.lua
    opts = {
        open_fold_hl_timeout = 0,
        preview = { win_config = { winhighlight = "Normal:Normal,FloatBorder:Normal" } },
        enable_get_fold_virt_text = true,
        close_fold_kinds = { "imports" }, -- + comments?
        fold_virt_text_handler = function(text, lnum, endLnum, width)
            local suffix = "  "
            local lines  = ('[%d lines] '):format(endLnum - lnum)

            local cur_width = 0
            for _, section in ipairs(text) do
                cur_width = cur_width + vim.fn.strdisplaywidth(section[1])
            end

            suffix = suffix .. (' '):rep(width - cur_width - vim.fn.strdisplaywidth(lines) - 3)

            -- TODO: Change these colors
            table.insert(text, { suffix, 'Comment' })
            table.insert(text, { lines, 'Comment' })
            return text
        end,
    },
    config = function (_, opts)
        vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.opt.foldmethod = 'manual'
        require('ufo').setup(opts)
    end
})

editor({
    'Wansmer/treesj',
    keys = {
        {
            "<leader>m",
            "<cmd>lua require('treesj').toggle()<cr>",
            desc = "Toggle join tree",
        },
    },
    config = function ()
        require('treesj').setup({
            use_default_keymaps = false,
        })
    end

})
