local M = {}


local jump = false

M.glance_keys = {
    {
        -- Glance definition, or jump if there is only one
        '<c-b>',
        function ()
            jump = true
            vim.cmd('Glance definitions')
        end,
        desc = 'Jump to definition'
    },
    {
        '<leader>gr',
        '<cmd>Glance references<cr>',
        desc = 'Glance references'
    },
    {
        '<leader>gd',
        '<cmd>Glance definitions<cr>',
        desc = 'Glance definitions'
    },
}


function M.glance()
    local glance = require('glance')
    glance.setup({
        hooks = {
            before_open = function(results, open, jump_to, method)
                if jump and #results == 1 then
                    -- TODO: is jump_to/open blocking?
                    jump = false
                    jump_to(results[1])
                else
                    jump = false
                    open(results)
                end
            end,
        }
    })
end


return M
