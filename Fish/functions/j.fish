# Defined in /tmp/fish.RbdwEp/j.fish @ line 17
function j
  set -l dir (jump cd "$argv")
  test -d "$dir"; and cd "$dir"
end
