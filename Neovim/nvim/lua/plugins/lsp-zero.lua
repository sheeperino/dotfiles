local M = {
  "VonHeikemen/lsp-zero.nvim",
  event = "VeryLazy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
}


function M.config()
  lsp = require("lsp-zero")
  lsp.ensure_installed({
    "sumneko_lua",
    "pylsp",
    "jsonls",
    "yamlls",
    "jdtls",
  })

  lsp.preset("lsp-only")

  lsp.setup()
end

return M
