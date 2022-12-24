local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
  install = { colorscheme = {"catppuccin"} }
})
 --   -- theme
 --   {"catppuccin/nvim",
 --     name = "catppuccin",
 --     config = function() require("plugins.catppuccin") end
 --   },
 --   -- status bar
 --   {"nvim-lualine/lualine.nvim",
 --     event = "UIEnter",
 --     config = function() require("plugins.lualine") end,
 --   },
 --   -- icons
 --   {"kyazdani42/nvim-web-devicons",
 --     lazy = true,
 --     config = function() require("nvim-web-devicons").setup() end
 --   },
 --   -- buffer-tab bar
 --   {"romgrk/barbar.nvim",
 --     event = "VeryLazy",
 --     config = function() require("plugins.barbar") end
 --   },
 --   -- terminal
 --   {"akinsho/toggleterm.nvim",
 --     cmd = {"ToggleTerm", "TermExec"},
 --     config = function() require("plugins.toggleterm") end
 --   },
 --   -- autopairs
 --   {"windwp/nvim-autopairs",
 --     event = "InsertEnter",
 --     config = function() require("nvim-autopairs").setup() end
 --   },
 --   -- comments
 --   {"numToStr/Comment.nvim",
 --     keys = {
 --       {"gc", "gb", mode = {"n", "v"}}
 --     },
 --     config = function() require("Comment").setup() end
 --   },
 --   -- surround functions
 --   {"kylechui/nvim-surround",
 --     event = "VeryLazy",
 --     config = function() require("nvim-surround").setup({ map_cr = true }) end
 --   },
 --   -- switch to opposite keywords
 --   {"AndrewRadev/switch.vim",
 --     cmd = "Switch"
 --   },
 --   -- run code
 --   {"CRAG666/code_runner.nvim",
 --     cmd = {"RunCode", "RunClose"},
 --     config = function() require("plugins.code-runner") end
 --   },
 --   -- auto completion + snippets
 --   {"ms-jpq/coq_nvim",
 --     branch = "coq",
 --     init = function() require("plugins.coq_nvim") end,
 --     dependencies = {"ms-jpq/coq.artifacts", branch = "artifacts"}
 --   },
 --   -- fuzzy file finder
 --   {"nvim-telescope/telescope.nvim",
 --     cmd = "Telescope",
 --     dependencies = {"nvim-lua/plenary.nvim", "BurntSushi/ripgrep"},
 --     config = function() require("plugins.telescope") end
 --   },
 --   -- session manager
 --   {"rmagatti/auto-session",
 --     event = { "BufRead", "BufWinEnter", "BufNewFile" },
 --     config = function() require("plugins.auto-session") end
 --   },
 --   -- rename with lsp
 --   {"smjonas/inc-rename.nvim",
 --     cmd = "IncRename",
 --     config = function() require("inc_rename").setup() end
 --   },
 --   -- markdown previewer
 --   {"ellisonleao/glow.nvim",
 --     cmd = "Glow",
 --     config = function() require("glow").setup() end
 --   },
 --   -- language server quick setup
 --   {"VonHeikemen/lsp-zero.nvim",
 --     event = "VeryLazy",
 --     config = function() require("plugins.lsp-zero") end,
 --     dependencies = {
 --       "neovim/nvim-lspconfig",
 --       "williamboman/mason.nvim",
 --       "williamboman/mason-lspconfig.nvim",
 --     }
 --   },
 --   -- eye candy for some prompts
 --   {"stevearc/dressing.nvim",
 --     event = "VeryLazy",
 --     config = function() require("dressing").setup() end
 --   },
 --   -- motion
 --   {"woosaaahh/sj.nvim",
 --     event = "VeryLazy",
 --     config = function() require("plugins.sj") end
 --   },
 --   -- minimal filesystem explorer
 --   {"katawful/dirbuf.nvim",
 --     cmd = "Dirbuf",
 --     config = function() require("dirbuf").setup({
 --       show_hidden = true,
 --       sort_order = "directories_first",
 --       devicons = true,
 --     })
 --     end
 --   },
 -- })
