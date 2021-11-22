#Include <Default_Settings>
;~ --------------------------------------
if (! A_IsAdmin){ ;http://ahkscript.org/docs/Variables.htm#IsAdmin
	Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
	ExitApp
}
Var:="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
window:= "ahk_class RegEdit_RegEdit"
Run, Regedit
WinWaitActive, % window,,10
WinActivate, % Window
SendInput, ^{l}
SendInput, !{d}
Send, % Var

F1::
SendInput, !{d}
Return