#NoEnv
#SingleInstance, force
#NoTrayIcon

; kill process
~#SC02E:: 
    WinClose, A
    WinWaitClose
return