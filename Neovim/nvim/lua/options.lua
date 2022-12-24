local set = vim.opt

-- special neovide settings
vim.g.neovide_cursor_animation_length = 0.0
-- 0.04
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_trail_lengt = 0.0
vim.g.neovide_refrsh_rate = 1111
-- vim.g.neovide_transparency = 1
set.guifont = 'FiraCode Nerd Font:h13'

-- change python version
vim.g.python3_host_prog="/usr/bin/python3.11"

-- general settings
set.mouse = ''
set.hidden = true
set.number = true
set.relativenumber = true
set.cursorline = true
set.hlsearch = false
set.ignorecase = true
set.termguicolors = true
set.cindent = true
set.wrap = false
set.lazyredraw = false
set.showmode = false

set.autochdir = true
set.scrolloff = 3

set.undofile = true
set.undodir= os.getenv("HOME") .. '/.nvim_undo'

-- auto-completion qol
set.completeopt = { "menuone", "noselect" }

-- tab size
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.autoindent = true
set.shiftround = true
set.smarttab = true
