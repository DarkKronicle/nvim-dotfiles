local M = {}

function M.vimtex()
    -- Don't show the bottom bar of errors
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_view_general_viewer = "okular"
    vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
end

return M
