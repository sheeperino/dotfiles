vim.g.catppuccin_flavour = 'mocha'
vim.cmd('colorscheme catppuccin')

-- cursor settings
vim.opt.guicursor = "n-v-c:blockCursor,i-ci-ve:ver25Cursor,r-cr:hor20Cursor,o:hor50Cursor"
vim.cmd("highlight Cursor gui=reverse guifg=NONE guibg=#cba6f7")

-- change completion transparency
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1E1E2E", fg = "#FFFFFF" })
vim.opt.pumblend = 50
