Run, % A_WinDir "\System32\SndVol.exe",,,vMixer
WinWaitActive, ahk_exe SndVol.exe
SysGet,Monitor,MonitorWorkArea, 1											;~ Get Primary Active Monitor
vW := A_ScreenWidth - (A_ScreenWidth/3)
vH := A_ScreenHeight - (A_ScreenHeight/2)
vX := MonitorLeft + (A_ScreenWidth - vW)
vY := MonitorBottom - (vH + 32)
WinMove, ahk_pid %vMixer%,, % vX, % vY, % vW, % vH
ExitApp