local map = aelius.map
-- Idea taken from nap
-- https://github.com/liangxianzhe/nap.nvim/blob/main/doc/nap.txt

local prev_key = "["
local next_key = "]"

local function map_pair(key, prev, prev_opt, next, next_opt)
    map("n", prev_key .. key, prev, prev_opt)
    map("n", next_key .. key, next, next_opt)
end

map_pair("a", 
    "<cmd>tabprevious<cr>", { desc = "Previous tab" },
    "<cmd>tabnext<cr>", { desc = "Next tab" }
)

map_pair("b", 
    "<cmd>bprevious<cr>", { desc = "Previous buffer" },
    "<cmd>bnext<cr>", { desc = "Next buffer" }
)

map_pair("t", 
    "<cmd>tprevious<cr>", { desc = "Previous tag" },
    "<cmd>tnext<cr>", { desc = "Next tag" }
)

map_pair("d", 
    vim.diagnostic.goto_prev, { desc = "Previous diagnostic" },
    vim.diagnostic.goto_next, { desc = "Next diagnostic" }
)

map({ "n", "v" }, "<leader>yp", '"+p', { desc = "Paste from system" })
map({ "n", "v" }, "<leader>yy", '"+y', { desc = "Copy to system" })


-- Re-select blocks after indenting in visual/select mode
-- https://github.com/rafi/vim-config/blob/master/lua/rafi/config/keymaps.lua
map('v', '<', '<gv', { desc = 'Indent right and re-select' })
map('v', '>', '>gv|', { desc = 'Indent left and re-select' })

map('v', '<Tab>', '<gv', { desc = 'Indent right and re-select' })
map('v', '<S-Tab>', '>gv|', { desc = 'Indent left and re-select' })

map('n', '<esc>', function ()
    vim.cmd('nohl')
    require('notify').dismiss()
end, { desc = 'Dismiss highlights and notifications' } )

map({ 'n', 'v' }, '<leader>w', "<cmd>w<cr>")
map({ 'n', 'v' }, '<leader>W', "<cmd>wa<cr>")
map({ 'n', 'v' }, '<leader>q', "<cmd>q<cr>")
map({ 'n', 'v' }, '<leader>Q', "<cmd>qa<cr>")


vim.cmd.cnoreabbrev('qw', 'wq')
vim.cmd.cnoreabbrev('aw', 'wa')
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

