Toggle_App(app, location) 
{
	if WinExist(app)   
	{
		if !WinActive(app)
		{
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