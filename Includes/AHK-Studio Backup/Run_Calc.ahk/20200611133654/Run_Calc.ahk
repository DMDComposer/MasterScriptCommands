#Include <Default_Settings>
Toggle_App("Calc", "C:\Windows\System32\calc.exe")
Return
ExitApp

Toggle_App(app, location) 
{
	if WinExist(app)   
	{
		msgbox, yes
		if !WinActive(app)
		{
			;~ WinActivate
			WinGet, winState, MinMax, % app
			msgbox, % winState
			If (winState = -1) {
				WinRestore % app
				WinActivate
				WinExist(app)
				WinGetPos,,, sizeX, sizeY
				WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
			}
			
			else if (winState = 1) {
				WinRestore % app
				WinExist(app)
				WinGetPos,,, sizeX, sizeY
				WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
				WinMaximize
			}
			
			else if (winState = 0) {
				WinExist(app)
				WinActivate
				WinGetPos,,, sizeX, sizeY
				WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
			}	
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
}