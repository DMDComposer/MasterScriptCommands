mscUtilities := new mscUtilities()
class mscUtilities extends MasterScriptCommands {
    runVSCode(workspaceDir) {
        local
        global A_AppDataLocal
        Run, "%A_AppDataLocal%\Programs\Microsoft VS Code\Code.exe" "%workspaceDir%",, Maximize, wndPID
        /*
         WinWait ahk_pid %wndPID%
                WinGet, wndState, MinMax, % "ahk_pid " wndPID
                if (!wndState)
                    WinRestore, % "ahk_pid " wndPID 
        */
    }
    toggleApp(app, location) {
    	if WinExist(app)
    		(!WinActive(app) ? WinActivate : WinMinimize)
    	if (location != "")
    		Run, % location
    }
    escapeBackSlash(string){
    	return RegExReplace(string, "\\", "\\$1")
    }
}