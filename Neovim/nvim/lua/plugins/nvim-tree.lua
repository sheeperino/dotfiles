require('nvim-tree').setup({
  view = {
    width = 20,
    mappings = {
      list = {
        { key = "E", action = "" }
      }
    }
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
})    
