require("catppuccin").setup({
  highlight_overrides = {
    all = function(colors)
      return {
        BufferCurrentTarget = { bold = false, italic = false, standout = true, fg = "#ccff88" },
        BufferVisibleTarget = { bold = false, italic = false, standout = true, fg = "#ccff88" },
        BufferInactiveTarget = { bold = false, italic = false, standout = true, fg = "#ccff88" },
      }
    end
  }
})
