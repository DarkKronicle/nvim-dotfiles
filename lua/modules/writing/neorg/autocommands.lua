local M = {}

M.setup = function()
M.necked = false

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
    }
})
end

return M
