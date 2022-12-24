local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {"nvim-lua/plenary.nvim", "BurntSushi/ripgrep"},
}

function M.config()
  require('telescope').setup{
    defaults = {
      layout_strategy = 'vertical',
      border = true,
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      mappings = {
        n = {
          ["l"] = "select_default"
        }
      },
      initial_mode = "insert"
    }
  }
end

return M
