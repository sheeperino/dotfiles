#SingleInstance, force
#WinActivateForce
SetBatchLines, -1
SendMode, Input
Process, Priority, , A
SetKeyDelay, 0

CheckRun(path :="", processName :="", arguments :="") {
    SplitPath, path,,,, nameNoExt
    Process := (processName) ? (processName) : (nameNoExt . ".exe") ; if a value has been assigned to processName
    process, exist, %Process%
    if (ErrorLevel) { 
            WinActivate, ahk_exe %Process% ; .exe
    }
    else {
        if (arguments) {
            Run, %path% %arguments%
        }
        else {
            Run, % path
        }
    }
}

Capitalization(mode) {
    Clipboard := ""
    Sleep 50
    Send ^c
    ClipWait
    ; StringReplace, Clipboard, Clipboard, `r`n, %A_Space%, All
    Clipboard := (mode == "lower") ? (Format("{:L}", Clipboard)) 
               : (mode == "upper") ? (Format("{:U}", Clipboard)) 
               : (mode == "title") ? (Format("{:T}", Clipboard))
               : (return)
    Send ^v
    ; Send % "{Text}" word ; "{Raw}" word  
}

; run programs, add a second argument if the process name is different than the file name
#SC030:: ; SC030 is b
    CheckRun("C:\Program Files\Mozilla Firefox\firefox.exe")
return

^>!#SC02E:: ; SC02E is c
    CheckRun("C:\Users\Sophie\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk")
return

#SC021:: ; SC021 is t
    CheckRun("C:\Program Files\Alacritty\alacritty.exe")
return

^>!#SC02F:: ; SC02F is v
    CheckRun("C:\Users\Sophie\AppData\Local\Programs\Microsoft VS Code\Code.exe")
return

#SC024::
    CheckRun("C:\ProgramData\chocolatey\bin\neovide.exe", "neovide.exe", "--multigrid")
return


; TO UPPER CASE
^PgUp::
    Capitalization("upper")
return

; to lower case
^PgDn::
    Capitalization("lower")
return

; To Title Case
^+PgUp::
    Capitalization("title")
return

; $LWin up::
; If (A_PriorKey = "LWin") ; LWin was pressed alone
;     Send, #{Tab}
; return

; In this case its necessary to define a custom combination by using "&" or "<#" 
; to avoid that LWin loses its original function as a modifier key:

; <#d:: Send #d  ; <# means LWin


LWin & AppsKey::Return
LWin::Send #{Tab}

#IfWinActive ahk_class Windows.UI.Core.CoreWindow
{
    Tab::Right
        +Tab::Left
        ^Tab::Down
        ^+Tab::Up
        +SC02E::^w ; SC02E is c
        ^LButton::MButton
        1::SendThing(1)
        2::SendThing(2)
        3::SendThing(3)
        4::SendThing(4)
        5::SendThing(5)
        6::SendThing(6)
        7::SendThing(7)
        8::SendThing(8)
        9::SendThing(9)

        return
        SendThing(value) {
            Send, {Right}
            sleep 50
                Send, {PgUp}{Right %value%}{Left 1}{Enter}
        }
}


; ~LWin Down::Send, #{Tab}
; Send {Blind}{vk07} ; prevents start menu from showing

