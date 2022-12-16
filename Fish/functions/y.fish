function y --wraps='youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0 ' --wraps='youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0' --description 'alias y=youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0'
  youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0 $argv; 
end
