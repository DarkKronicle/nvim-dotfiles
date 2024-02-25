local M = {}

function M.vimtex()
    -- Don't show the bottom bar of errors
    vim.g.vimtex_quickfix_mode = 0
end

return M
