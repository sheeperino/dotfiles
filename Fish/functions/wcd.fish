function wcd --wraps='cd (wslpath )' --description 'navigate to windows paths'
  cd (wslpath $argv); 
end
