Run, % A_WinDir "\System32\SndVol.exe",,,vMixer
WinWaitActive, ahk_exe SndVol.exe
WinGetPos,,,,vMixerHeight, ahk_pid %vMixer%
SysGet,Monitor,MonitorWorkArea, 1                    ;~ Get Primary Active Monitor
WinGetPos,,,,vTaskbarHeight, ahk_class Shell_TrayWnd ;~ Get Height of Windows Taskbar
vW := A_ScreenWidth - (A_ScreenWidth/3)
;~ vH := A_ScreenHeight - (A_ScreenHeight/2)
vH := vMixerHeight                                   ;~ Mixer can't be bigger than 350 height, so have to use this.
vX := MonitorLeft + (A_ScreenWidth - vW)
vY := A_ScreenHeight - (vH + vTaskbarHeight)
WinMove, ahk_pid %vMixer%,, % vX, % vY, % vW, % vH
ExitApp

WinGetPos,,,,h, ahk_class Shell_TrayWnd
yPad := 29, xPad := 9
guiW := guiH := 200
guiX := A_ScreenWidth-guiW-xPad
guiY := A_ScreenHeight-guiH-h-yPad
gui, show, x%guiX% y%guiY% w%guiW% h%guiH%, Guigui
sleep, 3000
exitapp 