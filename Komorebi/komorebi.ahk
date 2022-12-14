#SingleInstance Force
SetTitleMatchMode, 2
SetKeyDelay, -1
SetBatchLines, -1


; Disable hot reloading of changes to this file
Run, komorebic.exe watch-configuration disable, , Hide

; Disable focus follows mouse
Run, komorebic.exe focus-follows-mouse disable, , Hide
Run, komorebic.exe toggle-mouse-follows-focus, , Hide

; Ensure there are 3 workspaces created on monitor 0
Run, komorebic.exe ensure-workspaces 0 5, , Hide

; Give the workspaces some optional names
Run, komorebic.exe workspace-name 0 0 bsp, , Hide
Run, komorebic.exe workspace-name 0 1 columns, , Hide
Run, komorebic.exe workspace-name 0 2 thicc, , Hide
Run, komorebic.exe workspace-name 0 3 matrix, , Hide
Run, komorebic.exe workspace-name 0 4 floaty, , Hide

; Set the padding of the different workspaces
Run, komorebic.exe workspace-padding 0 0 0, , Hide
Run, komorebic.exe container-padding 0 0 12, , Hide
Run, komorebic.exe workspace-padding 0 1 100, , Hide
Run, komorebic.exe container-padding 0 1 100, , Hide
Run, komorebic.exe container-padding 0 1 30, , Hide
Run, komorebic.exe workspace-padding 0 2 200, , Hide
Run, komorebic.exe workspace-padding 0 3 100, , Hide
Run, komorebic.exe container-padding 0 3 0, , Hide

; Set the layouts of different workspaces
Run, komorebic.exe workspace-layout 0 1 columns, , Hide

; Set the floaty layout to not tile any windows
Run, komorebic.exe workspace-tiling 0 4 disable, , Hide

; Always show chat apps on the second workspace
Run, komorebic.exe workspace-rule exe slack.exe 0 1, , Hide

; Always float IntelliJ popups, matching on class
Run, komorebic.exe float-rule class SunAwtDialog, , Hide
; Always float Control Panel, matching on title
Run, komorebic.exe float-rule title "Control Panel", , Hide
; Always float Task Manager, matching on class
Run, komorebic.exe float-rule class TaskManagerWindow, , Hide
; Always float Wally, matching on executable name
Run, komorebic.exe float-rule exe Wally.exe, , Hide
Run, komorebic.exe float-rule exe wincompose.exe, , Hide
Run, komorebic.exe float-rule class Windows.UI.Core.CoreWindow, , Hide
Run, komorebic.exe float-rule exe paintdotnet.exe, , Hide
Run, komorebic.exe float-rule exe PowerToys.ColorPickerUI.exe, , Hide
; Run, komorebic.exe float-rule title "Discord", , Hide

; Always float Calculator app, matching on window title
Run, komorebic.exe float-rule title Calculator, , Hide
Run, komorebic.exe float-rule exe 1Password.exe, , Hide
Run, komorebic.exe float-rule exe javaw.exe, , Hide
Run, komorebic.exe float-rule exe obs64.exe, , Hide
Run, komorebic.exe float-rule exe vegas190.exe, , Hide

; Always manage forcibly these applications that don't automatically get picked up by komorebi
Run, komorebic.exe manage-rule exe TIM.exe, , Hide

; Identify applications that close to the tray
Run, komorebic.exe identify-tray-application exe Discord.exe, , Hide

; Identify applications that have overflowing borders
Run, komorebic.exe identify-border-overflow exe Discord.exe, , Hide

; Disable active window borders
Run, komorebic.exe active-window-border disable, , Hide

; Finish configuration
Run, komorebic.exe complete-configuration, , Hide


#IfWinNotActive ahk_exe javaw.exe

#InputLevel 1
Tab::F23
RShift::F24
#InputLevel 0

F23::
  SendInput, {Tab}
return
+F23::
  SendInput, {Shift Down}{Tab}{Shift Up}
return

F24::
  SendInput, {RShift}
return
; placeholder key combination
F23 & q::Return
F24 & q::Return

#If !WinActive("ahk_exe javaw.exe") && (GetKeyState("Tab", "P") || GetKeyState("RShift", "P")) 
; Change the focused window, Alt + Vim direction keys
h::
Run, komorebic.exe focus left, , Hide
return

j::
Run, komorebic.exe focus down, , Hide
return

k::
Run, komorebic.exe focus up, , Hide
return

l::
Run, komorebic.exe focus right, , Hide
return

esc::
mode := False
Gui 99:Destroy
return

; Toggle native maximize for the focused window, Alt + Shift + =
t::
Run, komorebic.exe toggle-monocle, , Hide
return

; Force a retile if things get janky, Alt + Shift + R
r::
Run, komorebic.exe retile, , Hide
return



; Move the focused window in a given direction, Alt + Shift + Vim direction keys

+h::
Run, komorebic.exe move left, , Hide
return

+j::
Run, komorebic.exe move down, , Hide
return

+k::
Run, komorebic.exe move up, , Hide
return

+l::
Run, komorebic.exe move right, , Hide
return

^h::
    Run, komorebic.exe resize-axis horizontal increase, , Hide
return

^j::
    Run, komorebic.exe resize-axis vertical increase, , Hide
return

^k::
    Run, komorebic.exe resize-axis vertical decrease, , Hide
return

^l::
    Run, komorebic.exe resize-axis horizontal decrease, , Hide
return

; Stack the focused window in a given direction, Alt + Shift + direction keys
+Left::
Run, komorebic.exe stack left, , Hide
return

+Down::
Run, komorebic.exe stack down, , Hide
return

+Up::
Run, komorebic.exe stack up, , Hide
return

+Right::
Run, komorebic.exe stack right, , Hide
return

+]::
Run, komorebic.exe cycle-stack next, , Hide
return

+[::
Run, komorebic.exe cycle-stack previous, , Hide
return

; Unstack the focused window, Alt + Shift + D
+d::
Run, komorebic.exe unstack, , Hide
return

; Promote the focused window to the top of the tree, Alt + Shift + Enter
Enter::
Run, komorebic.exe promote, , Hide
return

; Switch to an equal-width, max-height column layout on the main workspace, Alt + Shift + C
+c::
Run, komorebic.exe workspace-layout 0 0 columns, , Hide
return

;; Switch to the default bsp tiling layout on the main workspace, Alt + Shift + T
d::
Run, komorebic.exe workspace-layout 0 0 bsp, , Hide
return

p::
Run, komorebic.exe workspace-layout 0 3 matrix, , Hide
return

; Toggle the Monocle layout for the focused window, Alt + Shift + F
f::
Run, komorebic.exe toggle-maximize, , Hide
return
; Flip horizontally, Alt + X
x::
Run, komorebic.exe flip-layout horizontal, , Hide
return

; Flip vertically, Alt + Y
y::
Run, komorebic.exe flip-layout vertical, , Hide
return

; Float the focused window, Alt + T
+t::
Run, komorebic.exe toggle-float, , Hide
return

; Reload ~/komorebi.ahk, Alt + O
o::
Run, komorebic.exe reload-configuration, , Hide
return


; Switch to workspace
1::
Send !
Run, komorebic.exe focus-workspace 0, , Hide
return

2::
Send !
Run, komorebic.exe focus-workspace 1, , Hide
return

3::
Send !
Run, komorebic.exe focus-workspace 2, , Hide
return

4::
Send !
Run, komorebic.exe focus-workspace 3, , Hide
return

5::
Send !
Run, komorebic.exe focus-workspace 4, , Hide
return

; Move window to workspace
+1::
Run, komorebic.exe move-to-workspace 0, , Hide
return

+2::
Run, komorebic.exe move-to-workspace 1, , Hide
return

+3::
Run, komorebic.exe move-to-workspace 2, , Hide
return

+4::
Run, komorebic.exe move-to-workspace 3, , Hide
return

+5::
Run, komorebic.exe move-to-workspace 4, , Hide
return

flyout() {
        Gui, 99:+AlwaysOnTop -Caption +ToolWindow -SysMenu +Owner
        Gui, 99:Font, s14 bold, Fira Code
        Gui, 99:Add, Text, cCBA6F7, komorebi mode
        Gui, 99:Color, 660b4d
        Gui, 99:Show,NoActivate x125 y0, komorebiFlyout
        return
}
