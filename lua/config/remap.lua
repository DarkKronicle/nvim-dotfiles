local add_key = require('config/keymap').add_key


vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- vim.keymap.set({'n', 'v'}, 'p', "p'[=']", {noremap = true})
-- vim.keymap.set({'n'}, 'p', 'o<C-r><C-p>"<esc>\'[', {noremap = true})
-- vim.keymap.set({'v'}, 'p', '"_xO<C-r><C-p>"<esc>v\'[', {noremap = true})
--
-- vim.keymap.set({'n', 'v'}, 'P', "p", {noremap = true})

-- add_key("Move half page down", "n", "<C-d>", "<C-d>zz")
-- add_key("Move half page up", "n", "<C-u>", "<C-u>zz")

-- add_key("Next search item", "n", "n", "nzzzv")
-- add_key("Previous search item", "n", "N", "Nzzzv")

add_key("Paste from system", {"n", "v"}, "<leader>yp", "\"+p'[=']")

add_key("Copy into system clipboard", {"n", "v"}, "<leader>yy", "\"+y")

add_key(
    "Show spelling suggestions",
    "n", "<leader>s",
    function()
        require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
    end
)

add_key("Telescope open buffers", "n", "<leader>b",
    function()
        require("telescope.builtin").buffers()
    end
)

add_key("Jump to definition", "n", "<C-b>", function()
    vim.lsp.buf.definition()
end)

add_key("Generate documentation for current function", "n", "<leader>nd", ":lua require('neogen').generate()<CR>")

-- Re-select blocks after indenting in visual/select mode
-- https://github.com/rafi/vim-config/blob/master/lua/rafi/config/keymaps.lua
add_key('Indent right and re-select', 'v', '<', '<gv')
add_key('Indent left and re-select', 'v', '>', '>gv|')

-- Use tab for indenting in visual/select mode
add_key('Indent left', 'v', '<Tab>', '>gv|')
add_key('Indent right', 'v', '<S-Tab>', '<gv')

add_key('Clear search highlight', 'n', '<Esc>', '<CMD>noh<CR>')

add_key('Save', 'n', '<leader>w', '<CMD>w<CR>')
add_key('Save', {'n', 'i', 'v'}, '<C-S>', '<CMD>w<CR>')
add_key('Save and exit', 'n', '<leader>q', '<CMD>wq<CR>')

add_key("Append semicolon to current line if there isn't one", {'n', 'i'}, '<c-;>', function ()
    local line = vim.api.nvim_get_current_line()
    if line:sub(-1) ~= ';' then
        local m = line:match('%s*$')
        vim.api.nvim_set_current_line(line:sub(-m:len()) .. ';')
    end
end)

add_key('Leave', 'n', '<leader>Q', '<CMD>qall<CR>')

vim.cmd.cnoreabbrev('qw', 'wq')
vim.cmd.cnoreabbrev('Wq', 'wq')
vim.cmd.cnoreabbrev('WQ', 'wq')
vim.cmd.cnoreabbrev('Qa', 'qa')
vim.cmd.cnoreabbrev('Bd', 'bd')
vim.cmd.cnoreabbrev('bD', 'bd')



-- https://github.com/jdhao/nvim-config/blob/master/lua/mappings.lua#L194C1-L199C4
-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = { ",", ".", "!", "?", ";", ":", "(" }
for _, ch in ipairs(undo_ch) do
  vim.keymap.set("i", ch, ch .. "<c-g>u")
end

add_key("Add semicolon to end of line", {"i", "n"}, "<A-;>", "<Esc>miA;<Esc>`ii")

-- Text objects for URL
add_key("URL text object", { "x", "o" }, "iu", '<cmd>lua require("various-textobjs").url()<CR>')
add_key("Last edit object", { "x", "o" }, "ic", '<cmd>lua require("various-textobjs").lastChange()<CR>')

add_key("Paste", {"n","x"}, "p", "<Plug>(YankyPutAfter)")
add_key("Paste before", {"n","x"}, "P", "<Plug>(YankyPutBefore)")
add_key("Paste move cursor", {"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
add_key("Paste move cursor before", {"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

add_key("Yanky previous entry", "n", "<c-p>", "<Plug>(YankyPreviousEntry)")
add_key("Yanky next entry", "n", "<c-n>", "<Plug>(YankyNextEntry)")
