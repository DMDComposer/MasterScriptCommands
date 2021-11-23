#Include <Default_Settings>
Toggle_App("Calc.exe", "C:\Windows\System32\calc.exe")
Return
ExitApp

Toggle_App(app, location) 
{
	if WinExist(app)   
	{
		if !WinActive(app)
		{
			msgbox, yes
			WinActivate
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