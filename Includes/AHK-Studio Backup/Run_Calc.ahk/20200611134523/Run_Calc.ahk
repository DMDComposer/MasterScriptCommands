#Include <Default_Settings>
DetectHiddenWindows, Off ;ensure can find hidden windows
Toggle_App("Calculator", "C:\Windows\System32\calc.exe")
DetectHiddenWindows, On ;ensure can find hidden windows
Return
ExitApp

Toggle_App(app, location) 
{
	DetectHiddenWindows, Off ;ensure can find hidden windows
	if WinExist(app)   
	{
		if !WinActive(app)
		{
			WinActivate
			/*
				WinGet, winState, MinMax, % app
				If (winState = -1) {
					WinRestore % app
					WinActivate
					WinExist(app)
					WinGetPos,,, sizeX, sizeY
					WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2) ;~ Moves to center of screen
				}
				
				else if (winState = 1) {
					WinRestore % app
					WinExist(app)
					WinGetPos,,, sizeX, sizeY
					WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2) ;~ Moves to center of screen
					WinMaximize
				}
				
				else if (winState = 0) {
					WinExist(app)
					WinActivate, % app
					WinGetPos,,, sizeX, sizeY
					WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2) ;~ Moves to center of screen
				}	
			*/
		}
		else
		{
			WinMinimize
		}
	}
	else if location != ""
	{
		Run, %location%
	}
	DetectHiddenWindows, On ;ensure can find hidden windows
}