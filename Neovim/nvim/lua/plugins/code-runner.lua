local M = {
  "CRAG666/code_runner.nvim",
  cmd = {"RunCode", "RunClose"},
}

function M.config()
  require('code_runner').setup({
    mode = 'term',
    focus = true,
    filetype = {
      java = 'cd $dir; javac $fileName; java $fileNameWithoutExt',
      python = 'python -u',
      typescript = 'deno run',
      rust = 'cd $dir; rustc $fileName; $dir/$fileNameWithoutext',
      cpp = 'cd $dir; g++ $fileName -o $fileNameWithoutExt.exe; $fileNameWithoutExt.exe',
      autohotkey = 'cd $dir; /mnt/c/Users/Sophie/AppData/Local/Programs/AutoHotkey/v2/AutoHotkey64.exe $fileName'
    }  
  })
end

return M
