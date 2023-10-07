local M = {}


local function split_lines(text)
    local lines = {}
    for s in text:gmatch('[^\r\n]+') do
        table.insert(lines, s)
    end
    return lines
end


function M.get_screen_dimensions()
    local ui = vim.api.nvim_list_uis()[1]
    return ui['width'], ui['height']
end


function M.message_window(content)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, split_lines(content))
    local width, height = M.get_screen_dimensions()
    local win = vim.api.nvim_open_win(buf, false, {
        relative = 'editor',
        focusable = true,
        row = height / 2 - 15,
        col = width / 2 - 40,
        width = 80,
        height = 30,
    })
    return win

end


return M
