WinSet, Transparent, 255, ahk_class Shell_TrayWnd
; WinSet, Enable, ,ahk_class Shell_TrayWnd

ControlClick, Button2, ahk_class Shell_TrayWnd
sleep, 10000

; WinSet, Disable, , ahk_class Shell_TrayWnd
sleep, 100
WinSet, Transparent, 0, ahk_class Shell_TrayWnd


WinActivate, Program Manager

^<#t::
    WinSet, Transparent, 0, ahk_class Shell_TrayWnd
    WinSet, Disable, , ahk_class Shell_TrayWnd
return

^>#t::
    WinSet, Transparent, 255, ahk_class Shell_TrayWnd
    WinSet, Enable, , ahk_class Shell_TrayWnd
return