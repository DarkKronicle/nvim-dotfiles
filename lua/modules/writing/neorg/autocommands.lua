local M = {}
M.necked = false

M.setup = function()
    aelius.augroup("neorg", {
        {
            event = 'FileType',
            pattern = { "*.norg" },
            command = function(event)
                if not M.necked then
                    vim.cmd("NoNeckPain")
                    M.necked = true
                end
            end
        },
        {
            -- https://github.com/vsedov/nvim/blob/570f8187a7c74ec52182ce1e79c3e43deab58d69/lua/modules/notes/norg/autocmd.lua#L7
            event = 'BufWritePre',
            pattern = { "*.norg" },
            command = function(event)
                vim.cmd([[
                    normal m`gg=G``
                ]])
            end

        }
    })
end

return M
