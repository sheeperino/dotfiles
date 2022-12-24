local M = {
  "rmagatti/auto-session",
  event = {"BufRead", "BufWinEnter", "BufNewFile"},
}

function M.config()
  require('auto-session').setup({
    log_level = 'error',
    auto_session_enable_last_session = true,
  --  auto_session_root_dir = os.getenv("LOCALAPPDATA") .. '/nvim/auto-session/',
    auto_session_enabled = true,
    auto_save_enabled = false,
    auto_restore_enabled = true,
    auto_session_suppress_dirs = {"C:/Windows/System32/"}
  })
end

return M
