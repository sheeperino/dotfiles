#include TapAndHoldManager.ahk
#SingleInstance force

f1Remapper := new TapAndHoldManager("F1", Func("TapFunc").Bind("F1"))
f2Remapper := new TapAndHoldManager("F2", Func("TapFunc").Bind("F2"))

TapFunc(key, isHold, taps, state){
	ToolTip % key "`n" (isHold ? "HOLD" : "TAP") "`nTaps: " taps "`nState: " state
}

^Esc::ExitApp

