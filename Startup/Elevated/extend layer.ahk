; SetBatchLines, -1
; SetKeyDelay, -1
ListLines Off
SetBatchLines, -1
SetKeyDelay, -1, -1
SetWinDelay, -1
SetControlDelay, -1
Process, Priority,, H
Critical , On
SendMode Input

Run, % A_ScriptDir "\libs\mouseLayer.ahk"

; Vim Variables

global mode := "insert" ; normal, insert, visual, visual line, (replace?), command?, flyout, edit
global numMod := 1.1
global currentHold := ""
global keyCombo := ""
global modKeys := ["c", "d", "g", "y", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
global cutText := ""
global c := 0
global line := False


SetWorkingDir, C:\Users\Sophie\Desktop\vim stuff

LAlt::^RAlt

#InputLevel 1
#Persistent
SetCapsLockState, AlwaysOff
CapsLock::F22
#InputLevel 0


; digit 

; F22 & SC001::
; return

F22::CapsLock
; return

F22 & SC002::
  Send {Blind}{F1}
return

F22 & SC003::
  Send {Blind}{F2}
return

F22 & SC004::
  Send {Blind}{F3}
return

F22 & SC005::
  Send {Blind}{F4}
return

F22 & SC006::
  Send {Blind}{F5}
return

F22 & SC007::
  Send {Blind}{F6}
return

F22 & SC008::
  Send {Blind}{F7}
return

F22 & SC009::
  Send {Blind}{F8}
return

F22 & SC00A::
  Send {Blind}{F9}
return

F22 & SC00B::
  Send {Blind}{F10}
return

F22 & SC00C::
  Send {Blind}{F11}
return

F22 & SC00D::
  Send {Blind}{F12}
return

; top row

F22 & SC010::
  Send {Esc}
return

F22 & SC011::-

#if GetKeyState("Shift", "P") || GetKeyState("SC027", "P")
F22 & SC011::
  Send {_}
return
#if

F22 & SC012::
  Send {CtrlDown}{f}{CtrlUp}
return

F22 & SC013::+
  ; mouseclick, x2
  ; Send {Browser_Forward}
; return

F22 & SC014::
  ; Send {Insert}
  Send {Browser_Forward}
return

F22 & SC015::
  Send {Blind}{PgUp}
return

F22 & SC016::
  Send {Blind}{Home}
return

F22 & SC017::
  Send {Blind}{Up}
return

F22 & SC018::
  Send {Blind}{End}
return

F22 & SC00E::
  Send {AppsKey}
return

F22 & SC028::
  ; return
return

F22 & SC019::
  WinSet, AlwaysOnTop,, A
return

; middle row

F22 & SC01E::
  Send {CtrlDown}{a}{CtrlUp}
return


F22 & SC01F::
  Send {Blind}{LWinDown}
return

F22 & SC01F Up::
  Send {LWinUp}
return


F22 & SC020::
  Send {Blind}{AltDown}
return

F22 & SC020 Up::
  Send {AltUp}
return


F22 & SC021::
  Send {Blind}{CtrlDown}
return

F22 & SC021 Up::
  Send {CtrlUp}
return


; F22 & SC021 Up::
;   Send {CtrlUp}
return

F22 & SC022::
;   Send {Blind}{AltDown}
  Send {Browser_Back}
return

; F22 & SC022 Up::
;   Send {AltUp}
; return

F22 & SC023::
  Send {Blind}{PgDn}
return

F22 & SC024::
  Send {Blind}{Left}
return

F22 & SC025::
  Send {Blind}{Down}
return

F22 & SC026::
  Send {Blind}{Right}
return

F22 & SC027::
  Send {Blind}{ShiftDown}
return

F22 & SC027 Up::
  Send {ShiftUp}
return

F22 & SC001::  
  GetKeyState, cp, CapsLock, T
  if cp = D
    SetCapsLockState, AlwaysOff
  else
    SetCapsLockState, AlwaysOn
return

; bottom row

F22 & SC056:: ; -
  Send {CtrlDown}{y}{CtrlUp}
return


SendLevel 1
F22 & SC02C::
  Send {Blind}{LWinDown}
return

F22 & SC02C Up::
    Send {LWinUp}
return

; #if GetKeyState("AppsKey", "P")
; F22 & SC02C Up::
;     Send {LWinUp}
; return
; #if

F22 & SC02D:: ; +

;   Send {CtrlDown}{x}{CtrlUp}
  Send {Blind}{AltDown}
return

F22 & SC02D Up:: ; +

  Send {AltUp}
return

F22 & SC02E::

  Send {CtrlDown}{c}{CtrlUp}
return

F22 & SC02F::

  Send {CtrlDown}{v}{CtrlUp}
return

F22 & SC030::
  ; looool
return

F22 & SC031::=

;   mouseclick, left
; return

F22 & SC032::
return

F22 & SC033::
  Send {Blind}{Del}
return


; vim hotkey goes here

F22 & SC035::
  Send {Ctrl Down}
return

F22 & SC035 Up::
  Send {Ctrl Up}
return

;F22 & SC039::
;  Send {Space Down}{Space Up}
;return

; RAlt cancel caps / nav layer

; LAlt::
;   GetKeyState, cp, CapsLock, T
;   if navLayer 
;   {
;     navLayer := 0
;   } 
;   else if cp = D
;   {
;     SetCapsLockState, AlwaysOff
;   } 
; Return


; SYMBOL LAYER

; #If symbolLayer

; SC01E::1
; SC01F::2
; SC020::3
; SC021::4
; SC022::5
; SC023::6
; SC024::7
; SC025::8
; SC026::9
; SC027::0

; SC02C::+
; SC02D::{
; SC02E::[
; SC02F::(
; SC030::=
; SC031::)
; SC032::]
; SC033::}
; SC034::-
; +SC034::_
; SC035:::
; +SC035::;
; #If



; =================================
; VIM STUFF
; =================================

; Check the first lines for vim variables too

; Start vim

F22 & SC034::
  ; toggleSymbol:= !toggleSymbol
  ; MsgBox, % toggleSymbol
  ; Goto, VimInput
  global vimMode:= !vimMode
  if (vimMode ) ;|| mode != "normal"
    startVim()
  else
  {
    endFlyout()
    endVim()
  }
return


; badge()
#If (mode == "flyout")

SC001:: ; esc
  endFlyout()
return

SC00E:: ; backspace
  numMod := SubStr(NumMod, 1, StrLen(numMod)-1)
  currentHold := ""
  badge(numMod)
  if (StrLen(numMod) == 0)
    endFlyout()
return

+SC001::
  MsgBox, % numMod
return

#If



#If (mode == "normal")

SC001:: ; esc
  ; MsgBox, % mode
  endVim()
return

#If



; #If visualMode || visualMode

; SC001:: ; esc
;   MsgBox, visualmode
;   endVisualMode()
; return

; #If

; Zeroes


; 0 num modifier

#If (numMod != "" && numMod != 1.1 && numMod > 0 && mode == "flyout")
SC00B::
  numberThingy()
return


; Go To line

+SC014:: ; G (T on qwerty)
  Send, ^{g}{Text}%numMod%`r`n
  badge("G", True)
return

; 0 start of line

#If (mode == "normal")
SC00B:: ; 0 (zero)
  Send, {Home}
return

; End of file

+SC014:: ; G (T on qwerty)
  Send, ^{End}
return


#If (mode == "normal" || mode == "flyout" && mode != "command")

SC026:: ; i (l on qwerty)
  endVim()
return

+SC026:: ; Shift + i (I)
  Send, {Home}
  endVim()
return

SC01E:: ; a
  Send, {Right}
  endVim()
return

+SC01E:: ; Shift + a (A)
  Send, {End}
  endVim()
return

SC027:: ; o (; on qwerty)
  Send, {End}{Enter}
  endVim()
return

+SC027:: ; Shift + o (: on qwerty)
  Send, {Home}{Enter}{Up}
  endVim()
return


; Up/Left/Down/Right

SC031:: ; k (n on qwerty)
  Send, {Up %numMod%}
  numMod := 1.1
  badge("k", True)  
  PU := False
return
SC023:: ; h
  Send, {Left %numMod%}
  numMod := 1.1
  badge("h", True)  
return
SC015:: ; j (y on qwerty)
  Send, {Down %numMod%}
  numMod := 1.1
  badge("j", True)  
  PD := False
return
SC016:: ; l (u on qwerty)
  Send, {Right %numMod%}
  numMod := 1.1
  badge("l", True)  
return


; Previous/next word

SC030:: ; b
  Send, ^{Left %numMod%}
  badge("b", True)  
  numMod := 1.1
return
SC011:: ; w
  Send, ^{Right %numMod%}
  badge("w", True)  
  numMod := 1.1
return


; next end of word

SC025:: ; e (k on qwerty)
  Send, ^{Right %numMod%}{Left}
  badge("e", True)  
  numMod := 1.1
return


; end of line

+SC005:: ; Shift+4 ($)
  Send, {End}
return


; Start of line (after whitespace)

+SC007:: ; Shift+6 (^)
  Send, {Home}^{Right}
return



; Del/backspace

SC02D:: ; x
  Send, {Del %numMod%}
  badge("x", True)
  numMod := 1.1
return
+SC02D:: ; X
  Send, {Backspace %numMod%}
  badge("X", True)  
  numMod := 1.1
return


; Paste/paste before (paste/go left then paste)

SC013:: ; p (r on qwerty)
  if (line) {
    loop %numMod% {
      Send, {End}{Enter}{Home}
      Send, ^{v}
    }
  }
  else
    Send, ^{v}
 
  badge("p", True)
  numMod := 1.1
return

+SC013:: ; P / R
  if (line) {
    loop %numMod% {
      Send, {Home 2}{Enter}{Up}
      Send, ^{v}
      Send, {Up %c%}{Home 2}
    }
  }
  else
    Send, {Left}^{v}

  badge("P", True)
  numMod := 1.1  
return


; Key modifiers or whatever

; Start of document or global modifier

SC014:: ; g (t on qwerty)
  if (keyCombo == "g") {
    c := numMod - 1
    Send, ^{Home}{Down %c%}
    badge("g", True)    
  }
  else {
    badge("g")
    keyCombo .= "g"
  }
return

; Delete (cut) line or delete (cut) modifier

SC022:: ; d (g on qwerty)
  if (keyCombo == "d") {
    c := numMod - 1
    lineControl("x", "d")
  }
  else {
    badge("d")
    keyCombo .= "d"
    line := False
  }
return

; Delete (cut) to the end of line

+SC022:: ; Shift + d (D or G on qwerty)
  Send, +{End}^{x}
  c := numMod - 1
  lineControl("x", "D", True)
  badge("D", True)
return


; Yank (copy) line or yank modifier

; mfw abstraction (will fix sometime)

SC018:: ; y (o on qwerty)
  if (keyCombo == "y") { 
    c := numMod - 1
    lineControl("c", "y", False)
  }
  else {
    badge("y")
    keyCombo .= "y"
    line := False
  }
return

; Yank (copy) line to the end of line

+SC018:: ; Shift + y (Y or O on qwerty)
  Send, +{End}^{c}
  c := numMod - 1
  lineControl("c", "Y", False)
  badge("Y", True)
return

; Join line below with one space in between

+SC015:: ; Shift + j (J or Y on qwerty)
  Send, {End}{Del}{Space}
return


; Delete character and substitute text

SC020:: ; s (d on qwerty)
  Send, {Del}
  endVim()
return

; Delete line and substitute text

+SC020:: ; Shift + s (S or D on qwerty)
  Send, {End}{Shift Down}{Home}{Shift Up}{Del}
  endVim()
return


; Undo

SC017:: ; u (or i on qwerty)
  Send, ^{z}
return

; Redo (not from vim but similar)

+SC017:: ; Shift + u (U or I on qwerty)
  Send, ^{y}
return


; Move to top/bottom of the screen (bad code)

+SC023:: ; Shift + h (H)
  global PGd := False
  if (PU) {
    Send, {PgDn}
    PGu := False
  }
  if (PGu) 
    return
  Send, {PgUp}
  global PGu := True
return

+SC016:: ; Shift + l (L or U on qwerty)
  global PGu := False
  if (PD) {
    Send, {PgUp}
    PGd := False
  }
  if (PGd)
    return
  Send, {PgDn}
  global PGd := True
return


; Page Up/Down

^SC030:: ; Ctrl + b
  Send, {PgUp}
return

^SC012:: ; Ctrl + f (e on qwerty)
  Send, {PgDn}
return


; Move Up/Down 10 lines

^SC017:: ; Ctrl + u (i on qwerty)
  Send, {Up 10}
return

^SC022:: ; Ctrl + d (g on qwerty)
  Send, {Down 10}
return



; Enter command mode

+SC019:: ; Shift + ; (: or P on qwerty)
  badge(":", False, True)
  commandInput()
  ; mode := "command"
return


; Search

SC035:: ; /
  Send, ^{f}
return

; Next/previous result

SC021:: ; n j (on qwerty)
  Send, {F3}
return

+SC021:: ; Shift + n (N or J on qwerty)
  Send, +{F3}
return

; Search current word

+SC009:: ; Shift + 8 (*)
  Send, ^{Left}+^{Right}^{f}^{Right}
return



numberThingy() {
  if (numMod > 500)
    return

  if (numMod == 1.1)
    numMod := ""
  curr := GetKeyName(A_ThisHotkey)
  numMod .= curr
  ; badge(numMod)
  badge(curr)
  ; currentHold .= numMod
}

SC002:: ; 1
SC003:: ; 2
SC004:: ; 3
SC005:: ; 4
SC006:: ; 5
SC007:: ; 6
SC008:: ; 7
SC009:: ; 8
SC00A:: ; 9
  numberThingy()
return



#If (mode == "command")

commandInput() {
  Loop {
    if (InStr(ErrorLevel, "SC00E")) {
      global ch
      ch := SubStr(currentHold, 1, StrLen(currentHold)-1)
      currentHold := ""
      badge(ch)
      if (StrLen(ch) == 0) {
        endFlyout()
        break
      }
    }
    else if (InStr(ErrorLevel, "SC001")) {
      endFlyout()
      return
    }
    else if (InStr(ErrorLevel, "EndKey"))
      break
    badge(key, False, True)
    Input, key, L1, {Enter}{Esc}{Backspace}{SC01C}{SC001}{SC00E}{F22}
  }

  command := SubStr(currentHold, 2)

  ; Go to line
  if (RegExMatch(command, "^[0-9]+$"))
    Send, ^{g}{Text}%command%`r`n
  else
  {

    ; Line Range
    if RegExMatch(command, "\d") || InStr(command, ".,") || InStr(command, ",")
    {
      minMax := StrSplit(command, ",")
      args := StrSplit(minMax[2], A_Space)
      min := minMax[1]
      max := args[1]

      if (min is Integer || min == "." || max is Integer || max is == "$")
      {
        if (min != ".")
          Send, ^{g}{Text}%min%`r`n

        if (max is Integer && max != "$")
        {
          n := max - min
          if (n >= 0)
            Send, {ShiftDown}{Down %n%}{End}{ShiftUp}
          else
          {
            n := abs(n)
            Send, {ShiftDown}{Up %n%}{End}{ShiftUp}
          }
        }
        else if (max == "$" || min == ".")
          Send, +^{End}

        if (args[2] == "w") ; saves to filename
        {
          if (fileName := args[3]) {
            Send, ^{c}
            Clipwait
            FileDelete, %fileName%
            FileAppend, %Clipboard%, %fileName%
            Clipboard := ""
            Send, {Esc}
          }
        }
        
      }
      ; else if 

    }


    ; Save and quit shorthand
    else if (command == "x") || (command == "exit")
      command := "wq"

    ; Save file
    else if InStr(command, "w ") || InStr(command, "w") || if InStr(command, "write")
    {   
      if InStr(command, A_Space) {
        MsgBox, lool
        fileName := StrSplit(command, A_Space)[2]
        Send +^{s}
        sleep, 1000
        Send, {Text}%fileName%
      }
      else
        Send, ^{s}
    }

    ; Quit file
    if InStr(command, "q!") || InStr(command, "wq") || InStr(command, "q") || InStr(command, "quit")
    {
      if InStr(command, "!",, 2) {
        WinGet, pid, PID, A
        run, taskkill /F /PID %pid%,, Hide
      }
      else
        Send, !{F4}
    }


    ; ; Select lines ig
    ; if InStr(command, "%")
    ; {
    ;   if InStr(command, "d",, 2)
    ;     Send, ^{a}{Del}
      
    ; }
  }
  if InStr(ErrorLevel, "SC01C")
    sleep, 100
  endFlyout()
}

toClip() {
  Clipwait
  cutText := Clipboard
}

lineControl(key, letter, del= True) {
  Send, {Home 2}+{Down %c%}+{End}^{%key%}
  badge(%letter%, True)
  toClip()
  if (del)
    Send, {Del}
  line := True
  Send, {Blind}{Esc}
}



; Visual mode

; SC02F:: ; v

;   global visualMode:= !visualMode
;   if (visualMode)
;     startVisualMode()
;   else
;     endVisualMode()
; return


#If (mode == "visual" || mode == "visual line")

; Change marked text to lowercase

SC017:: ; u (i on qwerty)
  Send, ^{x}
  Clipwait
  prevClip := Clipboard
  s := Format("{:L}", Clipboard)
  
  Send, ^{v}
  Clipboard := prevClip
return

; Change marked text to uppercase

+SC017:: ; Shift + u (U or I on qwerty)
  Send, ^{x}
  Clipwait
  prevClip := Clipboard
  s := Format("{:U}", Clipboard)

  Send, ^{v}
  Clipboard := prevClip
return

; Switch case

+SC029:: ; Shift + ` (~)
  ; credits: https://www.autohotkey.com/board/topic/63122-change-the-case-of-a-string-five-options/

  Send, ^{x}
  Clipwait
  prevClip := Clipboard
  Clipboard := RegExReplace(Clipboard, "([A-Z])|([a-z])", "$L1$U2")
  
  Send, ^{v}
  Clipboard := prevClip
return

#If



isModifier(key) {
  ; for k, v in modKeys {
  ;   if (v == key){
  ;     MsgBox, % key ", " v "," is modifier
  ;     return True
  ;   }
  ; }
  ; return False

  for k, v in modKeys {
        if InStr(key, v)
            return True
  }
  return False
}


startVim() {

    ; GUI Credits:
    ; ahk-vim-navigation.ahk
    ; Written by Jongbin Jung

    mode := "normal"

    ; Gui, 99:Destroy
    Gui, 99:+AlwaysOnTop -Caption +ToolWindow -SysMenu +Owner
    ; Add and set the OSD Text
    Gui, 99:Font, s14 bold, Fira Code
    Gui, 99:Add, Text, cff79c6, -- NORMAL --
    ; OSD Background Color (Black)
    Gui, 99:Color, 000000
    Gui, 99:Show,NoActivate xCenter y1016, VimMode
    ; Sleep, %time%
    ; Gui, Destroy
    return
}

startVisualMode() {

    mode := "visual"

    Send, {Blind}{ShiftDown}
    visualMode := True
    ; vimMode := False

    ; Gui, Destroy
    Gui, 90:+AlwaysOnTop -Caption +ToolWindow -SysMenu +Owner
    ; Add and set the OSD Text
    Gui, 90:Font, s14 bold, Fira Code
    Gui, 90:Add, Text, c50e655, -- VISUAL --
    ; OSD Background Color (Black)
    Gui, 90:Color, 000000
    Gui, 90:Show,NoActivate xCenter y1016, VisualMode
    ; Sleep, %time%
    ; Gui, Destroy
    return
}

endVim() {
  mode := "insert"
  Gui, 99:Destroy
  Gui, 91:Destroy
  resetVariables()
  vimMode := False
  return
}

endVisualMode() {
  mode := "normal"
  Send, {ShiftUp}
  Gui, 90:Destroy
  resetVariables()
  return
}

endFlyout() {
  mode := "normal"
  Gui, 91:Destroy
  resetVariables()
  return
}

resetVariables() {
  numMod := 1.1
  currentHold := ""
  keyCombo := ""
}

badge(char = "", end= False, command= False) {
  ; MsgBox, % char
    currentHold .= char
    if (StrLen(currentHold) < 2 && end) {
      endFlyout()
      return
    }

    if command
      mode := "command"
    else
      mode := "flyout"
    resetGUI()
    ; Set the flags for OSD
    Gui, 91:+AlwaysOnTop -Caption +ToolWindow +Disabled -SysMenu +Owner
    ; Add and set the OSD Text
    Gui, 91:Font, s12 bold, Fira Code
    Gui, 91:Add, Text, cAA0000, %currentHold%
    ; OSD Background Color (Black)
    Gui, 91:Color, 000000
    Gui, 91:Show,NoActivate xCenter y500, VimFlyout
    ; Sleep, %time%
    ; Gui, 91:Destroy
    if (end) {
      sleep, 100
      endFlyout()
    }
    return
}

resetGUI()
{
    Gui, 91:Destroy
    return
}
    



; unused for now ==================================================


VimInput:

if (WinExist("vim input")) {
  if (!WinActive("vim input"))
    WinActivate, vim input
  return
}


global comList := ["d", "dd", "v", "V", "p", "yy", "$", "^", "g_", "0", "b", "w", "gg", "G", "u", "n", "e", "i"]


Gui, New
Gui, +AlwaysOnTop -Caption +ToolWindow -SysMenu +Owner
Gui, Add, Edit, w80 h17 x0 y0 vCommand
Gui, Add, Button, Default gOK Hidden 
Gui, Show, w80 h17 y80, vim input
return
OK:
Gui, Submit
    onlyNums := RegExReplace(Command, "\D")
    noNums := RegExReplace(Command, "[1-4294967295]")

    ; MsgBox, %onlyNums%, %noNums%



    if (inList(noNums))
    {

        Switch noNums
        {
          ; cut line
          Case "dd":
            Send, {End}{Shift Down}{Home}{Shift Up}{CtrlDown}{x}{CtrlUp}
            Clipwait
            cutText := Clipboard

          ; paste text
          Case "p":
            Send, {Text}%cutText%

          ; copy/yank line
          Case "yy":
            Send, {End}{Shift Down}{Home}{Shift Up}{CtrlDown}{c}{CtrlUp}  
            Clipwait
            cutText := Clipboard

          ; end/start of line
          Case "$":
            Send, {End}
          Case "0":
            Send, {Home}

          ; jump to the first non-blank character of the line
          Case "^":
            Send, {Home}^{Right}

          ; jump to the last non-blank character of the line
          Case "g_":
            Send, {End}^{Left}

          ; next/previous word
          Case "b":
            Send, ^{Left %onlyNums%}
          Case "w":
            Send, ^{Right %onlyNums%}

          ; first/last line of the document
          Case "gg":
            Send, ^{Home}
          Case "G":
            Send, ^{End}

          Case "u":
            Send, {Up %onlyNums%}
          Case "n":
            Send, {Left %onlyNums%}
          Case "e":
            Send, {Down %onlyNums%}
          Case "i":
            Send, {Right %onlyNums%}
        }

    }
return

;set the escape key to clear GUI window
GuiEscape: ; Note: single colon here, not double
Gui, Cancel
Return

inList(com) {
    for k, v in comList {
        if InStr(com, v)
            return True
    }
return False
}
return


