if [ (basename $PWD) = "system32" ]
  cd
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind \t accept-autosuggestion
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
