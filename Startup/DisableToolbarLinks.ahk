#NoEnv
#SingleInstance, force
Menu, Tray, NoIcon

Controls := ["ToolbarWindow322"]
Hide := True
For All, Control in Controls
	Control,% Hide?"Hide":"Show",,% Control, ahk_class Shell_TrayWnd

<!#f::
Hide := !Hide
For All, Control in Controls
	Control,% Hide?"Hide":"Show",,% Control, ahk_class Shell_TrayWnd
; WinHide, ahk_class Shell_TrayWnd
; WinShow, ahk_class Shell_TrayWnd ;refresh Shell_Tray
Return