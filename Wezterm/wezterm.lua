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
  font = wezterm.font("CaskaydiaCove Nerd Font Mono", { weight = "Regular" }),
  font_size = 13,
  animation_fps = 10,
  -- window_decorations = "RESIZE", -- temporarily disabled
  window_padding = {
    bottom = 0,
    top = 0,
    right = 0,
    left = 0,
  },
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  quick_select_alphabet = "arstqwfpxcdvneioluyhgkbjzm", -- optimized for colemak-dhk
  disable_default_key_bindings = true,

  -- mappings
  keys = {
    {
      key = 'd',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CopyTo("Clipboard"),
    },
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
      key = 'h',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitPane { direction = "Left" } ,
    },
    {
      key = 'l',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitPane { direction = "Right" } ,
    },
    {
      key = 'j',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitPane { direction = "Down" } ,
    },
    {
      key = 'k',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitPane { direction = "Up" } ,
    },
    {
      key = 's',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivatePaneDirection("Next") ,
    },
    {
      key = 't',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = 'n',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SpawnWindow,
    },
    {
      key = 'Backspace',
      mods = 'CTRL',
      action = wezterm.action { SendString = "\x17" },
    },
    {
      key = 'v',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
      key = 'Space',
      mods = 'SHIFT',
      action = wezterm.action.ShowTabNavigator,
    },
    {
      key = 'o',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ScrollByPage(0.5) ,
    },
    {
      key = 'i',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ScrollByPage(-0.5) ,
    },
  },
}
