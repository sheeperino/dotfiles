local M = {
  "kylechui/nvim-surround",
  event = "VeryLazy",
}

function M.config()
  require('nvim-surround').setup({
    map_cr = true
  })
end

return M
