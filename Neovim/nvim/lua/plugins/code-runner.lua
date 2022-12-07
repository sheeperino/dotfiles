require('code_runner').setup({
  mode = 'term',
  focus = true,
  filetype = {
    java = 'cd $dir; javac $fileName; java $fileNameWithoutExt',
    python = 'python -u',
    typescript = 'deno run',
    rust = 'cd $dir; rustc $fileName; $dir/$fileNameWithoutext',
    cpp = 'cd $dir; g++ $fileName -o $fileNameWithoutExt.exe; $fileNameWithoutExt.exe',
    autohotkey = 'cd $dir; AutoHotkey.exe $fileName'
  }  
})
