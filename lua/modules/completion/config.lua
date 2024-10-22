local M = {}

function M.sources() return {
        {
            name = 'nvim_lsp',
            priority = 10,
        },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'codeium' },
    }
end

function M.mappings()
    local luasnip = require('luasnip')
    local cmp = require('cmp')
    return {
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
        }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    }
end

function M.cmp()
    local codeium = require('codeium')

    -- https://github.com/Exafunction/codeium.nvim/issues/136
    local Source = require("codeium.source")

    vim.g["codeium_enabled"] = false

    local function is_codeium_enabled()
        local enabled = vim.b["codeium_enabled"]
        if enabled == nil then
            enabled = vim.g["codeium_enabled"]
            if enabled == nil then
                enabled = true -- enable by default
            end
        end
        return enabled
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function Source:is_available()
        local enabled = is_codeium_enabled()
        ---@diagnostic disable-next-line: undefined-field
        return enabled and self.server.is_healthy()
    end

    vim.api.nvim_set_keymap('n', '<leader>tC', '', {
        callback = function()
            local new_enabled = not is_codeium_enabled()
            vim.b["codeium_enabled"] = new_enabled
            if new_enabled then
                vim.notify("Codeium enabled in buffer")
            else
                vim.notify("Codeium disabled in buffer")
            end
        end,
        noremap = true
    })

    codeium.setup()
    local cmp = require('cmp')
    cmp.setup({
        sources = M.sources(),
        mapping = M.mappings(),
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        experimental = {
            ghost_text = true,
        }
    })

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }
        })
    })

end

return M
