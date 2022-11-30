require("todo-comments").setup({
  search = {
    command = "rg",
    args = {
      "--max-depth=1",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column"
    }
  }
})
