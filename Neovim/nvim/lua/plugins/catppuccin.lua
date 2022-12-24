local M = {
  "catppuccin/nvim",
  name = "catppuccin",
}

function M.config()
  require("catppuccin").setup({
    highlight_overrides = {
      all = function(colors)
        return {
          BufferCurrentTarget = { bold = false, italic = false, standout = true, fg = "#ccff88" },
          BufferVisibleTarget = { bold = false, italic = false, standout = true, fg = "#ccff88" },
          BufferInactiveTarget = { bold = false, italic = false, standout = true, fg = "#ccff88" },
        }
      end
    },
    integrations = {
      notify = true,
      mini = true,
    }
  })
end

return M
