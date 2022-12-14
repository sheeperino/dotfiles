-- mimic clipboard=unnamedplus because it's slow
-- copy to clipboard
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern  = '*',
  callback = function()
    vim.fn.setreg('+', vim.fn.getreg('"'))
  end
})
