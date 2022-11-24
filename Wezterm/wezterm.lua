local wezterm = require("wezterm")
local home_dir = "U:/home/sheepsophie/"

local wsl_domains = wezterm.default_wsl_domains()

for _, dom in ipairs(wsl_domains) do
    dom.default_cwd = "~"
end

return {
  wsl_domains = wsl_domains,
  default_domain = "WSL:Ubuntu-20.04",
  default_prog = {"wsl"},
  -- default_cwd = "U:/home/sheepsophie/",
  front_end = "OpenGL",
  window_close_confirmation = "NeverPrompt",
  max_fps = 120, -- this is an u8 int, MAX: 255 (120 seems to be the best from testing?)
  color_scheme = "Catppuccin Mocha",
  custom_block_glyphs = false,
  line_height = 1,
  default_cursor_style = "SteadyBlock",
  force_reverse_video_cursor = false,
  -- font = wezterm.font("FiraCode Nerd Font"),
  font = wezterm.font("CaskaydiaCove Nerd Font Mono", { weight = "Regular" }),
  font_size = 13,
  animation_fps = 10,
  window_decorations = "RESIZE",
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_and_split_indices_are_zero_based = true,
  quick_select_alphabet = "arstqwfpzxcvneioluymdhgjbk",

  -- mappings
  keys = {
    {
      key = 'w',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CloseCurrentTab { confirm = false },
    },
    {
      key = 'o',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
      key = 'o',
      mods = 'CTRL',
      action = wezterm.action.PaneSelect,
    },
    {
      key = 'Backspace',
      mods = 'CTRL',
      action = wezterm.action { SendString = "\x17" },
    },
    {
      key = 'v',
      mods = 'CTRL',
      action = wezterm.action.Paste,
    },
    {
      key = 't',
      mods = 'CTRL',
      action = wezterm.action.ActivateTabRelative(1),
    },
    -- {
    --   key = 'w',
    --   mods = 'CTRL',
    --   action = wezterm.action.ShowTabNavigator,
    -- },
  },
}
