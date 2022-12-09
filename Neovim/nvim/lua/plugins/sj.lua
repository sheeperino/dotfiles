local sj = require("sj")
sj.setup({
  auto_jump = true,
  forward_search = true,
  prompt_prefix = "sj: ",
  separator = "",
  relative_labels = true,
  -- optimized for colemak-dhk
  labels = {
    'a', 'r', 's', 't', 'q', 'w', 'f', 'p', 'x', 'c', 'd', 'v',
    'n', 'e', 'i', 'o', 'l', 'u', 'y', 'h', ',', '.',
    'g', 'k', 'b', 'j', 'z', 'm'
  },
  highlights = {
    -- inspired by leap.nvim
    SjFocusedLabel = { bold = false, italic = false, standout = true, fg = "#ccff88" },
    SjLabel = { bold = false, italic = false, standout = true, fg = "#ccff88" },
    SjLimitReached = { bold = false, italic = false, standout = true, fg = "#ccff88" },
    SjMatches =      { bold = false, italic = false, fg = "#7ec9d8"  },
    SjOverlay =      { bold = false, italic = false, fg = "#585b70",                 },
  },
})

vim.keymap.set({"n", "o", "x"}, "<Space>", sj.run)
vim.keymap.set({"n", "o", "x"}, "f", function()
	sj.run({
    max_pattern_length = 1,
    search_scope = "current_line" })
end)
