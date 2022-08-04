Process, Priority,, H
ListLines Off
CoordMode, Mouse, Screen
SetBatchLines, -1
SetMouseDelay, -1
SetKeyDelay, -1
#SingleInstance,Force
#NoTrayIcon
SetTitleMatchMode, 2
DetectHiddenWindows, On

global scrollSleep := 50 ; sleep before each scroll
global speed_x := 0
global speed_y := 0

; how quickly it accelerates i think
global t := 2 ; dividend for clamp_speed, default is 2

global ACCN := 1.6 ; formerly 0.75

show_Mouse(False)
MouseMove, 0, 0, 0
global mouseHidden := True

SetTimer, updateMouse, 0
Pause


fric := 1.35 ; friction, where 1 is no friction
clamp_speed := 100


a := ACCN
LCtrl & RAlt::
  if (mouseHidden) {
    if (A_TickCount - mouseHiddenTime) >= 3000
      MouseMove, A_ScreenWidth//2, A_ScreenHeight//2, 0
    else
      MouseMove, prevX, prevY
    show_Mouse()
    mouseHidden := False
  }
  Pause, Off
return

LCtrl & RAlt Up::
    if (!showcursorAlways) {
      show_Mouse(False)
      mouseHiddenTime := A_TickCount
      mouseHidden := True
      MouseGetPos, prevX, prevY
      MouseMove, 0, 0, 0
      BlockInput, MouseMove
    }
    Pause
    speed_x := 0
    speed_y := 0
    ; Send, {o up}{i up}
    mouse_down := False
    mouse_left := False
    mouse_right := False
    mouse_up := False
return

updateMouse:
    p_speed_y := speed_y
    p_speed_x := speed_x

    diagonal := ((mouse_up || mouse_down) && (mouse_left || mouse_right))
    ; speed_y += (mouse_up) ? -a : 0
    ; speed_y += (mouse_down) ? a : 0
    ; speed_x += (mouse_left) ? -a : 0
    ; speed_x += (mouse_right) ? a : 0
    speed_y += (mouse_down) ? (diagonal) ? +(a/Sqrt(2)) : +a : 0
    speed_y += (mouse_up) ? (diagonal) ? -(a/Sqrt(2)) : -a  : 0
    speed_x += (mouse_left) ? (diagonal) ? -(a/Sqrt(2)) : -a : 0
    speed_x += (mouse_right) ? (diagonal) ? +(a/Sqrt(2)) : +a  : 0

    ;quick direction change and slow down
    speed_x := (!mouse_right and speed_x > 0) ? (speed_x / fric) : ((!mouse_left and speed_x < 0) ? (speed_x / fric) : speed_x)
    speed_y := (!mouse_down and speed_y > 0) ? (speed_y / fric) : ((!mouse_up and speed_y < 0) ? (speed_y / fric) : speed_y)

    ;clamp values
    ; speed_x := ((speed_x) > clamp_speed) ? ((speed_x < 0) ? clamp_speed * -1 : clamp_speed) : speed_x
    ; speed_y := ((speed_y) > clamp_speed) ? ((speed_y < 0) ? clamp_speed * -1 : clamp_speed) : speed_y

    ; speed_y := (speed_y + p_speed_y) / t
    ; speed_x := (speed_x + p_speed_x) / t


    ; ToolTip, % "sx=" . speed_x . " sy=" . speed_y " ax=" . p_speed_x " ay=" . p_speed_y, 0, 0, 1 ; Debugging
    MouseMove, speed_x, speed_y,, R
return

show_Mouse(bShow := True) { ; show/hide the mouse cursor
;-------------------------------------------------------------------------------
    ; WINAPI: SystemParametersInfo, CreateCursor, CopyImage, SetSystemCursor
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms724947.aspx
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms648385.aspx
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms648031.aspx
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms648395.aspx
    ;---------------------------------------------------------------------------
    static BlankCursor
    static CursorList := "32512, 32513, 32514, 32515, 32516, 32640, 32641"
        . ",32642, 32643, 32644, 32645, 32646, 32648, 32649, 32650, 32651"
    local ANDmask, XORmask, CursorHandle

    If bShow { ; shortcut for showing the mouse cursor
        Return, DllCall("SystemParametersInfo"
            , "UInt", 0x57              ; UINT  uiAction    (SPI_SETCURSORS)
            , "UInt", 0                 ; UINT  uiParam
            , "Ptr",  0                 ; PVOID pvParam
            , "UInt", 0                 ; UINT  fWinIni
            , "Cdecl Int")              ; return BOOL
    }
    
    If Not BlankCursor { ; create BlankCursor only once
        VarSetCapacity(ANDmask, 32 * 4, 0xFF)
        VarSetCapacity(XORmask, 32 * 4, 0x00)

        BlankCursor := DllCall("CreateCursor"
            , "Ptr", 0                  ; HINSTANCE  hInst
            , "Int", 0                  ; int        xHotSpot
            , "Int", 0                  ; int        yHotSpot
            , "Int", 32                 ; int        nWidth
            , "Int", 32                 ; int        nHeight
            , "Ptr", &ANDmask           ; const VOID *pvANDPlane
            , "Ptr", &XORmask           ; const VOID *pvXORPlane
            , "Cdecl Ptr")              ; return HCURSOR
    }

    ; set all system cursors to blank, each needs a new copy
    Loop, Parse, CursorList, `,, %A_Space%
    {
        CursorHandle := DllCall("CopyImage"
            , "Ptr",  BlankCursor       ; HANDLE hImage
            , "UInt", 2                 ; UINT   uType      (IMAGE_CURSOR)
            , "Int",  0                 ; int    cxDesired
            , "Int",  0                 ; int    cyDesired
            , "UInt", 0                 ; UINT   fuFlags
            , "Cdecl Ptr")              ; return HANDLE

        DllCall("SetSystemCursor"
            , "Ptr",  CursorHandle      ; HCURSOR hcur
            , "UInt", A_Loopfield       ; DWORD   id
            , "Cdecl Int")              ; return BOOL
    }
}

#If !(A_IsPaused)

+f::
f::mouse_up := True
+f Up::
f Up::mouse_up := False
s::mouse_down := True
s Up::mouse_down := False
r::mouse_left := True
r Up::mouse_left := False
t::mouse_right := True
t Up::mouse_right := False
a::t := 2.17, a = 0.5, scrollSleep = 100
a Up::t := 2, a = ACCN, scrollSleep = 50
Space::t := 1.92, a = 1.5, scrollSleep = 25
Space Up::t := 2, a = ACCN, scrollSleep = 100

m::
  Send, {AltDown}
  MouseClick , Middle,,,,, D
  Send, {AltUp}
return
m Up::
  MouseClick , Middle,,,,, U
  Send, {AltUp}
return

n::
  a := 0.5
  MouseClick , Left,,,,, D
  KeyWait, SC024
return
n Up::
  MouseClick , Left,,,,, U
  a := ACCN
return
e::
  a := 0.5
  MouseClick , Right,,,,, D
  keyWait, SC025
return
e Up::
  MouseClick , Right,,,,, U
  a := ACCN
return
h::
  MouseClick , Middle,,,,, D
  keyWait, SC032
return
h Up::
  MouseClick , Middle,,,,, U
return

+i::
  SendInput, {WheelLeft 1}
  sleep, %scrollSleep%
return

+o::
  SendInput, {WheelRight 1}
  sleep, %scrollSleep%
return

i::
  SendInput, {WheelUp 1}
  sleep, %scrollSleep%
return

o::
  SendInput, {WheelDown 1}
  sleep, %scrollSleep%
return

u:: ; click on system tray
  CoordMode, Mouse, Screen
  Send, {Click 1815 18}
return

k::
  global showCursor := !showCursor
  if showCursor
  {
    show_Mouse()
    global showcursorAlways := True
    BlockInput, MouseMoveOff
  }    
  else
  {
    show_Mouse(False)
    global showcursorAlways := False
  }
return

#If
