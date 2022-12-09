vim.g.coq_settings = {
  ['xdg'] = true,
  ['display.pum.fast_close'] = false,
  ['display.preview.border'] = "single",
  ['display.ghost_text.context'] = { " ", " " },
  ['auto_start'] = 'shut-up',
  ['keymap.jump_to_mark'] = '<C-e>',
}

require('coq')
