require('lualine').setup({
  options = {
    theme = "catppuccin",
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {'NvimTree', 'defx', 'drex'}
  },
  sections = {
    lualine_x = {'filetype'},
    lualine_z = {}
  }
})
