local M = {
  "stevearc/oil.nvim",
  cmd = "Oil",
}

function M.config()
  require("oil").setup({
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 10,
      border = "none",
    },
    keymaps = {
      ["q"] = "actions.close",
    },
  })
end

return M
