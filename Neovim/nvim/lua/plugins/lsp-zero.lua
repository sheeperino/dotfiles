local lsp = require("lsp-zero")

lsp.ensure_installed({
  "sumneko_lua",
  "pylsp",
  "jsonls",
  "yamlls",
  "jdtls",
})

lsp.preset("lsp-only")

lsp.setup()
