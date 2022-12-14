-- you might have to change some mappings
-- depending on how your terminal handles Colemak-DH(k)

-- "lazyload" system clipboard copy
vim.keymap.set({"n", "o", "x", "v"}, "p", "<Cmd>set clipboard=unnamedplus<CR>p")
vim.keymap.set({"n", "o", "x", "v"}, "P", "<Cmd>set clipboard=unnamedplus<CR>P")

-- navigate through buffers
vim.api.nvim_set_keymap('n', '<Tab>', ':BufferNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferPrevious<CR>', { noremap = true, silent = true })

-- barbar
vim.api.nvim_set_keymap("n", "<S-t>", ":BufferPick<CR>", { noremap = true, silent = true })

-- navigate through splits
vim.api.nvim_set_keymap('n', '<C-s>', '<C-w>w', { noremap = true })

-- delete word with Ctrl + Backspace
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-BS>', '<C-w>', { noremap = true })

-- Ctrl + d with colemak dhk
-- vim.api.nvim_set_keymap('n', '<C-c>', '<C-d>', { noremap = false })

-- close tab
vim.api.nvim_set_keymap('n', '<C-w>t', '<C-w>c', { noremap = true, silent = true })
-- close buffer
vim.api.nvim_set_keymap('n', '<C-w>b', ':bd<CR>', { noremap = true, silent = true })

-- shortcut for yyp
vim.api.nvim_set_keymap('n', 'yp', 'yyp', { noremap = true })
vim.api.nvim_set_keymap('n', 'yP', 'yyP', { noremap = true })

-- keep visual mode after indent
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })

-- system clipboard
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-v>', '<C-o>"+p', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-v>', '<C-r>+', { noremap = true })
-- vim.api.nvim_set_keymap('v', '<C-c>', '<C-x>', { noremap = true })

-- visual mode swapping
vim.api.nvim_set_keymap('v', 'gs', '<Esc> `.``gvP``P', { noremap = true })

-- Control + enter and Shift + enter
vim.api.nvim_set_keymap('i', '<C-Enter>', '<Esc>o', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Enter>', '<Esc>O', { noremap = true })

-- terminal mappings :RunClose<CR>
vim.api.nvim_set_keymap('n', 'tt', ':ToggleTerm<CR><C-\\><C-n>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n> <C-w>c', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', 'qq', '<C-\\><C-n>', { noremap = true })

-- code-runner
vim.api.nvim_set_keymap('n', 'cr', ':w<CR>:RunCode<CR>', { noremap = true, silent = true })

-- vim switch
vim.api.nvim_set_keymap('n', 'gs', ':Switch<CR>', { noremap = true, silent = true })

-- nvim-tree
-- vim.api.nvim_set_keymap('n', '<S-e>', ':NvimTreeToggle<CR>', { noremap = false, silent = true })

-- tab thingy (i couldn't map this in lua)
-- vim.cmd([[
-- inoremap <expr> <Tab> pumvisible() ? '<C-n>' : search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'
-- ]])

-- telescope
vim.api.nvim_set_keymap('n', 'tg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tf', ':Telescope find_files<CR>', { noremap = true, silent = true })

-- lsp
local bufopts = { noremap=true, silent=true, buffer=0 }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, bufopts)

-- leap.nvim
-- vim.api.nvim_set_keymap("n", "s", ":lua require('leap').leap{target_windows={vim.fn.win_getid()}}<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("o", "s", ":lua require('leap').leap{target_windows={vim.fn.win_getid()}}<CR>", { noremap = true })

-- local sj = require("sj")
-- vim.keymap.set("n", "s", sj.run)
-- vim.keymap.set("v", "s", sj.run)

vim.api.nvim_set_keymap("n", "<S-e>", ":Dirbuf %<CR>", { silent = true })
