mscRunAHKCommand := new mscRunAHKCommand()
class mscRunAHKCommand extends MasterScriptCommands {
    getMSCRunAHKCommand(command) {
        global neutron
    	toggleMSC(neutron)
    	static Shell   := ComObjCreate("WScript.Shell")
    		 , AhkPath := "C:\Program Files\AutoHotkey\AutoHotkey.exe"
    		 , header  := "#Include <Default_Settings>`n"
    		 , footer  := "`nExitApp"
    		 , Params  := ""
    	Script := header . command . footer
    	Name   := "\\.\pipe\AHK_MSC_" A_TickCount
    	Pipe   := []
    	Loop, 3
    	{
    		Pipe[A_Index] := DllCall("CreateNamedPipe"
    							   , "Str", Name
    							   , "UInt", 2, "UInt", 0
    							   , "UInt", 255, "UInt", 0
    							   , "UInt", 0, "UPtr", 0
    							   , "UPtr", 0, "UPtr")
    	}
    	if !FileExist(AhkPath)
    		throw Exception("AutoHotkey runtime not found: " AhkPath)
    	if (A_IsCompiled && AhkPath == A_ScriptFullPath)
    		AhkPath .= " /E"
    	if FileExist(Name) 	{
    		Exec := Shell.Exec(AhkPath " /CP65001 " Name " " Params)
    		DllCall("ConnectNamedPipe", "UPtr", Pipe[2], "UPtr", 0)
    		DllCall("ConnectNamedPipe", "UPtr", Pipe[3], "UPtr", 0)
    		FileOpen(Pipe[3], "h", "UTF-8").Write(Script)
    	}
    	else ; Running under WINE with improperly implemented pipes
    	{
    		FileOpen(Name := "AHK_MSC_TMP.ahk", "w").Write(Script)
    		Exec := Shell.Exec(AhkPath " /CP65001 " Name " " Params)
    	}
    	Loop, 3
    		DllCall("CloseHandle", "UPtr", Pipe[A_Index])
    	return Exec
    }
}