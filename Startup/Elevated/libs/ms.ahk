Process, Priority,, H
ListLines Off
CoordMode, Mouse, Screen
SetBatchLines, -1
SetMouseDelay, -1
#SingleInstance,Force
#NoTrayIcon
SetTitleMatchMode, 2
DetectHiddenWindows, On

global scrollSleep := 50

global speed_x := 0
global speed_y := 0
global t := 2 ; dividend for clamp_speed, default is 2

SetTimer, updateMouse, 15
Pause

fric := 1.5 ; friction, where 1 is no friction
clamp_speed := 100

LCtrl & RAlt::Pause, Off
LCtrl & RAlt Up::
    Pause
    speed_x := 0
    speed_y := 0
return

#If !(A_IsPaused)

f::mouse_up := True
f Up::mouse_up := False
s::mouse_down := True
s Up::mouse_down := False
r::mouse_left := True
r Up::mouse_left := False
t::mouse_right := True
t Up::mouse_right := False
a::t := 2.17
a Up::t := 2
Space::t := 1.92
Space Up::t := 2

k::
  Send, {AltDown}
  MouseClick , Middle,,,,, D
  Send, {AltUp}
return
k Up::
  MouseClick , Middle,,,,, U
  Send, {AltUp}
return

n::
  MouseClick , Left,,,,, D
  KeyWait, SC024
return
n Up::
  MouseClick , Left,,,,, U
return
e::
  MouseClick , Right,,,,, D
  keyWait, SC025
return
e Up::
  MouseClick , Right,,,,, U
return
m::
  MouseClick , Middle,,,,, D
  keyWait, SC032
return
m Up::
  MouseClick , Middle,,,,, U
return

+i::
    while (GetKeyState("i", "P") && GetKeyState("Shift", "P")) {
        Send, {WheelLeft}
        sleep, 50
    }
return

+o::
    while (GetKeyState("o", "P") && GetKeyState("Shift", "P")) {
        Send, {WheelRight}
        sleep, 50
    }
return

i::
    while (GetKeyState("i", "P")) {
        Send, {WheelUp}
        sleep, 50
    }
return

o::
    while (GetKeyState("o", "P")) {
        Send, {WheelDown}
        sleep, % scrollSleep 
    }
return

u:: ; click on system tray
  CoordMode, Mouse, Screen
  Send, {Click 1815 18}
return

#If
updateMouse:
    p_speed_y := speed_y
    p_speed_x := speed_x

    speed_y += (mouse_up) ? -1 : 0
    speed_y += (mouse_down) ? 1 : 0
    speed_x += (mouse_left) ? -1 : 0
    speed_x += (mouse_right) ? 1 : 0

    ;quick direction change and slow down
    speed_x := (!mouse_right and speed_x > 0) ? (speed_x / fric) : ((!mouse_left and speed_x < 0) ? (speed_x / fric) : speed_x)
    speed_y := (!mouse_down and speed_y > 0) ? (speed_y / fric) : ((!mouse_up and speed_y < 0) ? (speed_y / fric) : speed_y)

    ;clamp values
    speed_x := (Abs(speed_x) > clamp_speed) ? ((speed_x < 0) ? clamp_speed * -1 : clamp_speed) : speed_x
    speed_y := (Abs(speed_y) > clamp_speed) ? ((speed_y < 0) ? clamp_speed * -1 : clamp_speed) : speed_y

    speed_y := (speed_y + p_speed_y) / t
    speed_x := (speed_x + p_speed_x) / t

    ; ToolTip, % "sx=" . speed_x . " sy=" . speed_y " ax=" . Abs(speed_x) " ay" . Abs(speed_y), 0, 0, 1 ; Debugging
    MouseMove, speed_x, speed_y,, R
return
