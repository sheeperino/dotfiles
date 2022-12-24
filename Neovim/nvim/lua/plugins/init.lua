-- plugins without a custom config
return {
  -- autopairs
  {"windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  -- icons
  {"kyazdani42/nvim-web-devicons",
    lazy = true,
    config = true
  },
  -- comments
  {"numToStr/Comment.nvim",
    keys = {
      {"gc", "gb", mode = {"n", "v"}}
    },
    config = true
  },
  -- switch to opposite keywords
  {"AndrewRadev/switch.vim",
    cmd = "Switch"
  },
  -- rename with lsp
  {"smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true
  },
  -- markdown previewer
  {"ellisonleao/glow.nvim",
    cmd = "Glow",
    config = true
  },
  -- eye candy for some prompts
  {"stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true
  },
  -- mapping helper
  {"folke/which-key.nvim",
    event = "VeryLazy",
    config = true
  },
}
