local M = {
  "katawful/dirbuf.nvim",
  cmd = "Dirbuf",
}

function M.config()
  require("dirbuf").setup({
    show_hidden = true,
    sort_order = "directories_first",
    devicons = true
  })
end

return M
