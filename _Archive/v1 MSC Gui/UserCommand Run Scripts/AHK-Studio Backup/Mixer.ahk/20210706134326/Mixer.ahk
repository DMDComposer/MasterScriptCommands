Run, % A_WinDir "\System32\SndVol.exe",,,vMixer
WinWaitActive, ahk_exe SndVol.exe
SysGet,Monitor,MonitorWorkArea, 1 ;~ Get Primary Active Monitor
WinGetPos,,,,vTaskbarHeight, ahk_class Shell_TrayWnd ;~ Get Height of Windows Taskbar
yPad := 29
vW := A_ScreenWidth - (A_ScreenWidth/3)
vH := A_ScreenHeight - (A_ScreenHeight/2)
vX := MonitorLeft + (A_ScreenWidth - vW)
;~ vY := MonitorBottom - (vH + vTaskbarHeight)
vY := A_ScreenHeight - (vH + vTaskbarHeight + yPad)
WinMove, ahk_pid %vMixer%,, % vX, % vY, % vW, % vH

DebugWindow(vY)

ExitApp

WinGetPos,,,,h, ahk_class Shell_TrayWnd
yPad := 29, xPad := 9
guiW := guiH := 200
guiX := A_ScreenWidth-guiW-xPad
guiY := A_ScreenHeight-guiH-h-yPad
gui, show, x%guiX% y%guiY% w%guiW% h%guiH%, Guigui
sleep, 3000
exitapp 