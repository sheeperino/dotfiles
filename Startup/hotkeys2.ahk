#SingleInstance, force
SetBatchLines, -1
SetTitleMatchMode, 2
SendMode, Input
Process, Priority, , A
SetKeyDelay, 0

CheckRun(path :="", processName :="", processType :="", arguments :="") {
    ; path: used to run the application
    ; processName: used to check if the process exists
    ; processType: used to specify the type of process [ahk_exe, ahk_class, (Title)]
    ; arguments: used to add arguments to run along with the application

    Process, exist, %processName%
    if (!ErrorLevel) {
        if (arguments) {
            Run, %path% %arguments%
        }
        else {
            Run, % path
        }
        WinWait, %processType% ; Wait for window to open
    }
    WinActivate, %processType%
}

; kinda unused
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

#SC030:: ; SC030 is b
    CheckRun("C:\Program Files\Mozilla Firefox\firefox.exe", "firefox.exe", "Mozilla Firefox")
return

^>!#SC02E:: ; SC02E is c
    CheckRun("C:\Users\Sophie\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk", "discord.exe", "Discord")
return

#SC021:: ; SC021 is t
    CheckRun("C:\Program Files\Alacritty\alacritty.exe", "alacritty.exe", "Alacritty")
return

^>!#SC02F:: ; SC02F is v
    CheckRun("C:\Users\Sophie\AppData\Local\Programs\Microsoft VS Code\Code.exe")
return

#SC024::
    CheckRun("C:\ProgramData\chocolatey\bin\neovide.exe", "neovide.exe", "Neovide", "--multigrid")
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

