local function setup_firenvim()
    vim.opt.shortmess = 'ilnxtToOF'
    vim.opt.guifont = {"Cascursive", "h8"}
    -- vim.cmd(":SoftPencil<CR>")
    vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
        callback = function(e)
            vim.cmd(":set filetype=markdown<CR>")
            vim.cmd(":SoftPencil<CR>")
        end
    })
    vim.api.nvim_create_autocmd({'TextChanged', 'TextChangedI'}, {
        callback = function(e)
            if vim.g.timer_started == true then
                return
            end
            vim.g.timer_started = true
            vim.fn.timer_start(10000, function()
                vim.g.timer_started = false
                vim.cmd('write')
            end)
        end
    })
end


vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never",
            filename = '/tmp/{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.md'
        }
    }
}

if vim.g.started_by_firenvim then
    vim.opt.laststatus = 0
    setup_firenvim()
else
    -- vim.opt.laststatus = 2
end
