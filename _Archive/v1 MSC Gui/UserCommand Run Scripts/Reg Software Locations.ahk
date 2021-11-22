#Include <Default_Settings>
;~ --------------------------------------
if (! A_IsAdmin){ ;http://ahkscript.org/docs/Variables.htm#IsAdmin
	Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
	ExitApp
}
Var:=Clipboard
InputBox,App,Regedit Find,"Enter the keyword or title of the software you whish to find?"
Var:="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
window:= "ahk_class RegEdit_RegEdit"
Run, Regedit
WinWaitActive, % window,,10
WinActivate, % Window
Sleep, 100
Send, !{d}
Send, ^{v}
Send, {Enter}
Send, {F3}
Send, % App
;~ ControlClick,Button5,Find ahk_class #32770,,L,,NA
Send, +{Tab 3}{Enter}
Clipboard:=Var
ExitApp
