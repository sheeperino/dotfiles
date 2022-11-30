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
    initial_mode = "normal"
  }
}
