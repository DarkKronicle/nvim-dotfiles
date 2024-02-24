local get_bufs = function()
    return vim.tbl_filter(function(bufnr)
        return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
    end, vim.api.nvim_list_bufs())
end


-- Show bufferline/tabline if buffers > 1
aelius.augroup("bufferline", {
    {
        event = { "VimEnter", "UIEnter", "BufAdd", "BufDelete" },
        command = function()
            vim.schedule(function()
                local buffers = get_bufs()
                -- check how many buffers we have and set showtabline accordingly
                if #buffers > 1 then
                    vim.o.showtabline = 2 -- always
                elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
                    vim.o.showtabline = 1 -- only when #tabpages > 1
                end
            end)
        end,
    },
})

aelius.augroup("util", {
    {
        -- Make directory if it doesn't exist
        event ='BufWritePre',
        command = function(event)
            if event.match:match('^%w%w+://') then
                return
            end
            local file = vim.loop.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
        end,
    },
    {
        -- Make q close some filetypes
        event = 'FileType',
        pattern = {
            'blame',
            'checkhealth',
            'fugitive',
            'fugitiveblame',
            'help',
            'httpResult',
            'lspinfo',
            'notify',
            'PlenaryTestPopup',
            'qf',
            'spectre_panel',
            'startuptime',
            'tsplayground',
        },
        command = function(event)
            vim.bo[event.buf].buflisted = false vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
        end,
    },
    {
        -- No undo/swap for temporary file types
        event = 'BufWritePre',
        pattern = { '/tmp/*', '*.tmp', '*.bak', 'COMMIT_EDITMSG', 'MERGE_MSG' },
        command = function(event)
            vim.opt_local.undofile = false
            if event.file == 'COMMIT_EDITMSG' or event.file == 'MERGE_MSG' then
                vim.opt_local.swapfile = false
            end
        end,
    },
    {
        -- Make the terminal look better
        event = 'TermOpen',
        command = function(_)
            vim.opt_local.spell = false
            vim.opt_local.scrolloff = 0
            vim.opt_local.sidescrolloff = 0
            vim.opt_local.relativenumber = false
            vim.opt_local.number = false
            vim.opt_local.signcolumn = "no"
            vim.opt_local.statuscolumn = ""
        end,

    },
})

-- jk moves based on visual, not exact
aelius.augroup("writing", {
    {
        event = {"BufEnter", "BufWinEnter"},
        pattern = {"*.md", "*.norg", "*.tex"},
        command = function()
            vim.keymap.set('n', 'j', 'gj', { buffer = true })
            vim.keymap.set('n', 'k', 'gk', { buffer = true })
        end,
    },
})

-- Only set cursorline in normal mode
aelius.augroup("cursorline", {
    {
        event = { 'InsertLeave', 'WinEnter' },
        command = function(event)
            if vim.bo[event.buf].buftype == '' then
                vim.opt_local.cursorline = true
            end
        end,
    },
    {
        event = { 'InsertEnter', 'WinLeave' },
        command = function(_)
            vim.opt_local.cursorline = false
        end,
    },
})



