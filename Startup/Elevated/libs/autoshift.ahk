#NoEnv
#Persistent
#SingleInstance force
#MaxThreads 25
#MaxHotkeysPerInterval 200

#Warn LocalSameAsglobal, OutputDebug
#Warn UseEnv, OutputDebug
#Warn UseUnsetLocal, OutputDebug

SetWorkingDir %A_ScriptDir%  ;; Ensures a consistent starting directory.
SetBatchLines -1
Process, Priority, , High
SendMode Input

global HoldKeyDownTime := 0
global HoldKeyModifier := ""
global LimitKeyHeld := 125
global LimitKeyHeldForShift := 171 ;; needs to be at least four milliseconds less than next variable
global LimitKeyWaitForShift = "T0.175"
global KeyBefore := ""
global KeyBeforeBefore := ""
global KeyBeforeSpace := ""
global LastKeyHeld := 0
global KeyName := ""
return ;- ;; Don't delete - has structural purpose!

#MaxThreadsPerHotkey 1

$a::
$b::
$c::
$d::
$e::
$f::
$g::
$h::
$i::
$j::
$k::
$l::
$m::
$n::
$o::
$p::
$q::
$r::
$s::
$t::
$u::
$v::
$w::
$x::
$y::
$z::
$0::
$1::
$2::
$3::
$4::
$5::
$6::
$7::
$8::
$9::
$,::
$SC034:: ;; period
$SC035:: ;; hyphen
	Key_HandleKeyDown()
return

Key_CheckIfKeyHeld(KeyToCheck := "") ;+
{
	if (AlreadyCheckingIfKeyHeld = 1) ;; some hold hotkey already in process > skip this press <> get rid of KeyWait, which is unreliable for some media keys
	{
		return
	}
	AlreadyCheckingIfKeyHeld := 1
	PriorHotKey := A_PriorKey

	if (KeyToCheck) ;; needs to be completely unmodified
		ThisHoldKey := KeyToCheck ;; set to key name passed as argument
	else
	{
		ThisHoldKey := Key_HotkeyTrimmed() ;; remove ~$!+# prefixed to get unmodified name of pressed key
		;; Combinations of modifiers don't work so far.
		if (InStr(A_Thishotkey, "!")) ;; Alt + key was pressed
			HoldKeyModifier := "Alt"
		if (InStr(A_Thishotkey, "^")) ;; Ctrl + key was pressed
			HoldKeyModifier := "Ctrl"
		if (InStr(A_Thishotkey, "+")) ;; Shift + key was pressed
			HoldKeyModifier := "Shift"
	}
	
	HoldKeyDownTime := A_TickCount ;; note the time at which the hotkey was pressed down
	TimerDuration := LimitKeyHeld + 5
	if (HoldKeyModifier)
		TimerDuration := TimerDuration + 50 ;; increase interval for slower modified hotkeys
	SetTimer, T_KeyHeld, -%TimerDuration%
} ;-
Key_HandleKeyDown() ;+ ;; BM_KeyDown [navigation node; don't delete]
{
	KeysDownDuringSpaceDown := ""
	KeysDownAfterSpace := ""
	SpaceFNWentBefore := 0 ;; clear when any new letter key is pressed
	ReversedSpaceFN := 0
	KeyBeforeBefore := KeyBefore
	KeyBefore := KeyName
	;; KeyBefore := A_Priorkey
	KeyName := GetKeyName(Key_HotkeyTrimmed())
	;; PP_Cmd(".Misc@Debug(?§KN: " . KeyName . " - A_P:" . A_PriorKey . " - KB: " . KeyBefore . " - KBB: " . KeyBeforeBefore . "§)")
	KeyDownTime := A_TickCount

	
	if (HandleKeyDownAlreadyActive) ;+
	{
		KeyDownBuffer := KeyDownBuffer . GetKeyName(KeyName)
		LastKeyHeld := 0
		return
	}
	HandleKeyDownAlreadyActive := 1 ;-
	
	if (StrLen(KeyName) = 1)
	{
		Send % GetKeyState("Capslock", "T") ? "+" . GetKeyName(KeyName) : GetKeyName(KeyName) ;; send the standard character first
		SetCapsLockState, Off
	}

	KeyBeforeHold := A_PriorKey
	KeyWait, %KeyName%, %LimitKeyWaitForShift% ;; then check if key held
	if (A_PriorKey = "Space" and KeyBeforeHold != "Space")
	{
		Key_HKDExit(KeyName)
		return
	}
	if (errorlevel) ;+ ;; key held
	{
		LastKeyHeld := 1
		
		if (KeyDownBuffer != "") ;; a different hotkey has since been activated
		{
			Key_HKDExit(KeyName)
			return
		}
		
		Send, % "{Backspace}+" . GetKeyName(KeyName)
	} else
		LastKeyHeld := 0
	
	Key_HKDExit(KeyName)
	return
} ;-
Key_HKDExit(KeyName) ;+
{
	;; F23LeftThumbDeadKeyMod := 0
	HandleKeyDownAlreadyActive := 0
	;; SendRaw, %KeyDownBuffer% ;; send keypresses that overlapped with time window to check if first key was held
	if (!KeyRoll)
		Send, %KeyDownBuffer% ;; send keypresses that overlapped with time window to check if first key was held
	KeyDownBuffer := ""
	KeyWait, %KeyName% ;; prevent key repeat
	;; PP_Cmd(".Misc@Debug(?§N: " . KeyName . "; B: " . KeyBefore . "; P: " . A_PriorKey . "§)")
	return
	;; Exit ;; Don't use as KeyName sometimes needs to be changed after exiting.
} ;-
Key_HotkeyTrimmed(KeyToTrim := "") ;+
{
	if (KeyToTrim = "")
		 KeyToTrim := A_Thishotkey
	TrimChar := RegExMatch(KeyToTrim, "[0-9a-zA-Z,]") ;; Remove prefix modifiers from key by looking for the first letter - or number - character
	;; OutputDebug [AHK]  %TrimChar%
	TrimChar-- ;; Lower count by 1 as nothing is to be trimmed when no special characters are found
	StringTrimLeft, A_ThisNewHotkey, KeyToTrim, %TrimChar%
	if (RegExMatch(KeyToTrim, "[&]")) ;; Remove prefixed custom modifier keys
	{
		TrimChar := RegExMatch(KeyToTrim, "[&]") + 1
		StringTrimLeft, A_ThisNewHotkey, KeyToTrim, %TrimChar%
	}
	StringReplace, A_ThisNewHotkey, A_ThisNewHotkey, %A_Space%Up, , All
	Return, A_ThisNewHotkey
} ;-

;; #Include c:\Users\PK\Documents\AHK\OSD.ahk
;-

T_KeyHeld: ;+
	;; osd(ThisHoldKey . " " . GetKeyState(ThisHoldKey, "P") . " A_TC: " . A_TickCount . " ThisDown: " . HoldKeyDownTime)

	if (A_TickCount - HoldKeyDownTime > LimitKeyHeld)
	{
		;; if ((ThisHoldKey = "F16" and GetKeyState("d", "P")) or (ThisHoldKey != "F16" and GetKeyState(ThisHoldKey, "P"))) ;; make sure the key is still held down and hasn't been pressed repeatedly
		if ((ThisHoldKey = "F16" and GetKeyState("d", "P")) or GetKeyState(ThisHoldKey, "P") or ) ;; make sure the key is still held down and hasn't been pressed repeatedly
		{
			Gosub % HoldKeyModifier . ThisHoldKey . "_Held"
		}
	}
	HoldKeyModifier := ""
	AlreadyCheckingIfKeyHeld := 0
return ;-

return