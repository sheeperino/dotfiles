local M = {
  "ms-jpq/coq_nvim",
  branch = "coq",
  dependencies = {"ms-jpq/coq.artifacts", branch = "artifacts"},
}

function M.init()
  vim.g.coq_settings = {
    ['xdg'] = true,
    ['display.pum.fast_close'] = false,
    ['display.preview.border'] = "single",
    ['display.ghost_text.context'] = { " ", " " },
    ['auto_start'] = 'shut-up',
    ['keymap.jump_to_mark'] = '<C-e>',
  }

  require('coq')
end

return M
