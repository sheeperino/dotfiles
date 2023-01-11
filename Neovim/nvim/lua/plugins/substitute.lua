local M = {
  "gbprod/substitute.nvim",
  event = "VeryLazy"
}

function M.config()
  require("substitute").setup()
  -- substitute
  vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
  vim.keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
  vim.keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
  vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
  -- exchange
  vim.keymap.set("n", "sc", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
  vim.keymap.set("n", "scc", "<cmd>lua require('substitute.exchange').line()<cr>", { noremap = true })
  vim.keymap.set("x", "C", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })
  -- vim.keymap.set("n", "sxc", "<cmd>lua require('substitute.exchange').cancel()<cr>", { noremap = true })
end

return M
