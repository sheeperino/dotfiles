vim.g.catppuccin_flavour = 'mocha'
vim.cmd('colorscheme catppuccin')

-- cursor settings
vim.opt.guicursor = "n-v-c:blockCursor,i-ci-ve:ver25Cursor,r-cr:hor20Cursor,o:hor50Cursor"
vim.cmd("highlight Cursor gui=reverse guifg=NONE guibg=#cba6f7")
