local M = {
  "romgrk/barbar.nvim",
  event = "VeryLazy",
}

function M.config()
  require('bufferline').setup({
    animation = false,
    auto_hide = true,

    closable = false,
    clickable = false,

    icons = false,

    icon_separator_active = '',
    icon_separator_inactive = '',

    letters = "arstqwfpxcdvneioluyhgkbjzm" -- optimized for colemak dhk
  })
end

return M
