local M = {
  "akinsho/toggleterm.nvim",
  cmd = {"ToggleTerm", "TermExec"},
}

function M.config()
  require('toggleterm').setup({
    direction = "horizontal",
    shade_terminals = false,
    persist_size = true,
  })
end

return M
