local M = {}
M.necked = false

M.setup = function()
    aelius.augroup("neorg", {
        {
            event = 'FileType',
            pattern = { "norg" },
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
                aelius.disable_animate = true
                vim.cmd([[
                    normal m`gg=G``zz
                ]])
                aelius.disable_animate = false
            end

        }
    })
end

return M
