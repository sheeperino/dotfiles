local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function()

  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use {'catppuccin/nvim',
        as = 'catppuccin',
        config = function() require("plugins.catppuccin") end
  }

  use {'nvim-lualine/lualine.nvim',
        -- event = 'UIEnter',
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function() require('plugins.lualine') end
  }

  use {"andweeb/presence.nvim",
        event = {"BufRead", "BufNewFile", "BufWinEnter"},
        config = function() require("plugins.presence") end
  }

  use {'kyazdani42/nvim-web-devicons',
        -- event = 'UIEnter',
        after = "lualine.nvim",
        config = function() require('nvim-web-devicons').setup{} end
  }

  use {'romgrk/barbar.nvim',
        -- event = 'UIEnter',
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function() require('plugins.barbar') end
  }

  use {'akinsho/toggleterm.nvim',
        cmd = {'ToggleTerm', 'TermExec'},
        config = function() require('plugins.toggleterm') end
  }

  use {'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function() require('nvim-autopairs').setup{} end
  }

  use {'numToStr/Comment.nvim',
        keys = {'gc', 'gb'},
        config = function() require('Comment').setup{} end
  }

  use {'kylechui/nvim-surround',
        event = 'BufReadPre',
        config = function() require('nvim-surround').setup{ map_cr = true } end
  }

  use {'AndrewRadev/switch.vim',
        cmd = 'Switch'
  }

  use {'CRAG666/code_runner.nvim',
        cmd = {'RunCode', 'RunClose'},
        config = function() require('plugins.code-runner') end
  }

  use {'ms-jpq/coq_nvim',
        branch = 'coq',
        event = {"BufRead", "BufNewFile", "BufWinEnter"},
        setup = function() require("plugins.coq_nvim") end
        -- config = function()
          -- require('coq')
        -- end
  }
  use {'ms-jpq/coq.artifacts',
        branch = 'artifacts',
        event = 'InsertEnter',
        -- event = {"BufRead", "BufNewFile", "BufWinEnter"},
        after = "coq_nvim"
  }

  use {'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        requires = {'nvim-lua/plenary.nvim',
                    'BurntSushi/ripgrep'},
        config = function() require('plugins.telescope') end
  }
  use {'BurntSushi/ripgrep',
        after = "telescope.nvim"
  }

  use {'rmagatti/auto-session',
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function() require('plugins.auto-session') end
      }

  use {"smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = function() require("inc_rename").setup() end
  }

  use {"ellisonleao/glow.nvim",
        cmd = "Glow",
        config = function() require("glow").setup() end
  }

  use {'VonHeikemen/lsp-zero.nvim',
        event = "BufReadPre",
        -- event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function() require("plugins.lsp-zero") end,
        requires = {
          {'neovim/nvim-lspconfig'},
          {'williamboman/mason.nvim',
            -- cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" }
          },
          {'williamboman/mason-lspconfig.nvim'},
        }
  }

  use {"folke/todo-comments.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function() require("plugins.todo-comments") end
  }

  use {'stevearc/dressing.nvim',
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function() require("dressing").setup() end
  }

  -- use {"rlane/pounce.nvim"}

  use {"woosaaahh/sj.nvim",
        event = { "BufRead", "BufWinEnter", "BufNewFile" },
        config = function() require("plugins.sj") end
  }

  use {"katawful/dirbuf.nvim",
        cmd = "Dirbuf",
        -- to remove hashes see :h dirbuf-faq
        config = function() require("dirbuf").setup({
          show_hidden = true,
          sort_order = "directories_first",
          devicons = true,
        })
        end
  }

  use {"ms-jpq/chadtree",
        cmd = "CHADopen",
        config = function() require("plugins.chadtree") end
  }

  if packer_bootstrap then
    require('packer').sync()
  end

end)
