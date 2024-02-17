vim.filetype.add({
    extension = {
        nu = "nu",
        nush = "nu",
        nuon = "nu",
        nushell = "nu",
    },
})

local function augroup(name)
    return vim.api.nvim_create_augroup('darkkronicle_' .. name, {})
end

-- Latex functions
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    group = augroup("latex"),
    pattern = {"*.md", "*.norg"},
    callback = function()
        vim.keymap.set('n', 'j', 'gj', { buffer = true })
        vim.keymap.set('n', 'k', 'gk', { buffer = true })
    end
})


-- Writing based commands
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    group = augroup("writing"),
    pattern = {"*.md", "*.norg"},
    callback = function()
        vim.cmd("SoftPencil")

        vim.keymap.set('n', 'j', 'gj', { buffer = true })
        vim.keymap.set('n', 'k', 'gk', { buffer = true })
    end
})

local function get_errors()
    -- https://github.com/nvim-lualine/lualine.nvim/blob/45e27ca739c7be6c49e5496d14fcf45a303c3a63/lua/lualine/components/diagnostics/sources.lua#L46
    local diagnostics = vim.diagnostic.get(0)
    local count = { 0, 0, 0, 0 }
    for _, diagnostic in ipairs(diagnostics) do
      count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
    return count[vim.diagnostic.severity.ERROR]
end

-- Auto open trouble if there are errors on save
vim.api.nvim_create_autocmd({"FileType"}, {
    callback = function ()
        if get_errors() > 0 then
            vim.cmd('Trouble')
        else
            vim.cmd('TroubleClose')
        end
    end
})

-- Auto move help to the right side
vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = 'help',
    callback = function ()
        vim.cmd('wincmd L')
    end
})


-- Only set cursorline in normal mode
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    group = augroup('cursorline_show'),
    callback = function(event)
        if vim.bo[event.buf].buftype == '' then
            vim.opt_local.cursorline = true
        end
    end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    group = augroup('cursorline_hide'),
    callback = function(_)
        vim.opt_local.cursorline = false
    end,
})

-- Highlight yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('highlight_yank'),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Make dir if it doesn't exist
vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup('mkdir'),
    callback = function(event)
        if event.match:match('^%w%w+://') then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('close_filetype'),
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
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
    end,
})


-- No undo files or swap files for temporary files
vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup('temp_files'),
    pattern = { '/tmp/*', '*.tmp', '*.bak', 'COMMIT_EDITMSG', 'MERGE_MSG' },
    callback = function(event)
        vim.opt_local.undofile = false
        if event.file == 'COMMIT_EDITMSG' or event.file == 'MERGE_MSG' then
            vim.opt_local.swapfile = false
        end
    end,
})

vim.api.nvim_create_autocmd('TermOpen', {
    group = augroup('term'),
    callback = function(_)
        vim.opt_local.spell = false
        vim.opt_local.scrolloff = 0
        vim.opt_local.sidescrolloff = 0
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.statuscolumn = ""
    end,
})

