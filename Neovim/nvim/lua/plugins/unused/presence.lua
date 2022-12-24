-- use ":" ig???
require('presence'):setup({
  neovim_image_text = 'Neovim',
  main_image = 'file',
  enable_line_number = true
})

-- check https://github.com/andweeb/presence.nvim/wiki/Rich-Presence-in-WSL#wsl-1
-- to setup presence on WSL (it works on WSL2 too)
-- then add the following line to the last line of /etc/sudoers RUN WITH sudo visudo !!
-- <sheepsophie ALL=(root) NOPASSWD: /path/to/discord-relay.sh>
