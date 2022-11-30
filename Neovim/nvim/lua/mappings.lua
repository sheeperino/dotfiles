-- you might have to change some mappings
-- depending on how your terminal handles Colemak-DH(k)

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

-- defx stuff

-- vim.api.nvim_set_keymap('n', '<S-e>',
-- ':Defx -winwidth=20 -split=vertical -direction=topleft -columns=icons:indent:filename:type -post-action=jump -root-marker= -ignored-files="" -auto-cd <CR>',
-- { noremap = false, silent = true })
--
-- function defx_mappings()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local buf_map = vim.api.nvim_buf_set_keymap
--
--
--   buf_map(bufnr, 'n', 'E', "<Nop>", { noremap = true, silent = true })
--   buf_map(bufnr, 'n', 'l', "defx#do_action('drop')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'h', "defx#do_action('cd', ['..'])", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'q', "defx#do_action('quit')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'd', "defx#do_action('remove')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'x', "defx#do_action('move')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'y', "defx#do_action('copy')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'p', "defx#do_action('paste')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'Y', "defx#do_action('yank_path') . '<CR>'", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'r', "defx#do_action('rename')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'o', "defx#do_action('execute_system')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'cd', "defx#do_action('change_vim_cwd')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', '~', "defx#do_action('cd')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'a', "defx#do_action('new_file')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'm', "defx#do_action('new_multiple_files')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 's', "defx#do_action('toggle_select') . 'j'", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'S', "defx#do_action('toggle_select_all')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', '.', "defx#do_action('print')", { noremap = true, silent = true, expr = true })
--   buf_map(bufnr, 'n', 'R', "defx#do_action('redraw')", { noremap = true, silent = true, expr = true })
-- end  
--
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'defx',
--   callback = function()
--     vim.schedule(defx_mappings)
--   end
-- })
