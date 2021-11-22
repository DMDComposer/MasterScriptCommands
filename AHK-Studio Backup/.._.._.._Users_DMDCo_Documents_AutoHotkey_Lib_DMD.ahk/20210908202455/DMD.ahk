DMD_RemoveExtraSpaces(string){
	Return Trim(RegExReplace(string, "\h\K\h+"))
}
DMD_RestoreClip(Clip,SleepNum := 0){
	RestoreClip := ClipboardAll
	Clipboard   := Clip
	ClipWait, 1
	if (ErrorLevel)
		Msgbox % "Nothing on Clipboard"
	Sleep, % SleepNum ;~ wait for window to reactivate.
	SendEvent, ^v
	Sleep, 100        ;~ Sleep needed otherwise could error and send original clipboard, if error still raise the sleep time
	Clipboard   := RestoreClip
}
DMD_MoveWindow(Run,Info){
	for Key, Value in {Position:["C","BL","BR","TL","TR"],Size:""}
		if(!Info[Key])
			Info[Key] := Value
	vRun      := Run
	vPosition := Info.Position
	vSize     := Info.Size = Space ? "2" : Info.Size     ;~ Default is 2 unless specified
	SysGet,Monitor,MonitorWorkArea, 1                    ;~ Get Primary Active Monitor
	WinGetPos,,,,vTaskbarHeight, ahk_class Shell_TrayWnd ;~ Get Height of Windows Taskbar
	if vRun != Space
	{
		Run, % vRun,,,vRunPID
		vWindow := "ahk_pid " vRunPID
		while(!WinActive(vWindow)){                     ;~ Keep trying to activate window
			WinActivate % vWindow
			Sleep, 100
		}
	}
	vW := A_ScreenWidth / vSize
	vH := A_ScreenHeight - (A_ScreenHeight / vSize) - (vTaskbarHeight-13)
	WinMove, % vWindow,,,, % vW, % vH                    ;~ Set W/H before moving to calculate "Center" properly
	if(vPosition ~= "i)(B[LR])|(T[LR])"){		
		vX := vPosition ~= "i)[BT]L" ? MonitorLeft : MonitorLeft + (A_ScreenWidth - vW)
		vY := vPosition ~= "i)B[LR]" ? A_ScreenHeight - (vH + vTaskbarHeight) : 7
	}
	if WinActive(vWindow)
		WinGetPos,vWindowX,vWindowY,vWindowW,vWindowH, % vWindow
	if(vPosition ~= "i)C"){
		vX := (A_ScreenWidth - vWindowW) / 2 
		vY := (A_ScreenHeight - vWindowH) / 2
	}
	WinMove, % vWindow,, % vX, % vY                      ;~ Move window into calculated position
}
DMD_GetAppsInfo(App, Type :="1"){
	SetBatchLines, -1
;~ Explains the object tree, so oArr.1 = DisplayName, oArr.11 = Install Location
	headers := ["DISPLAYNAME"
			, "VERSION"
			, "PUBLISHER"
			, "PRODUCTID"           
			, "REGISTEREDOWNER"
			, "REGISTEREDCOMPANY"
			, "LANGUAGE"
			, "SUPPORTURL"           
			, "SUPPORTTELEPHONE"
			, "HELPLINK"
			, "INSTALLLOCATION"
			, "INSTALLSOURCE"           
			, "INSTALLDATE"
			, "CONTACT"
			, "COMMENTS"
			, "IMAGE"
			, "UPDATEINFOURL"]
	
	data := []           
	for k, v in headers
		data.Push( GetAppsInfo({ mask: v, offset: A_PtrSize*(k - 1) }) )
	
	oArr := []
	for k, v in data
		for i, j in v
			oArr[i, k] := j
	oObj := []
	for index, AppInfo in oArr  
	{
		oObj[AppInfo.1] .= AppInfo.11
		str .= (index = 1 ? "" : "`r`n")
		for i, j in AppInfo
		{
			str .= (i = 1 ? "" : ", ") . j
		}
	}
	oPath := []
	if (Type == 1)
	{
		for Key, Value in oObj
		{
			if (key ~= "i)" App)
				oPath.Push(Value)
		}
		Return oPath
	}
	if (Type == 0)
	{
		for Key, Value in oObj
		{
			if (key ~= "i)" App)
				vPath .= Value "`n"
		}
		Return vPath
	}
}
DMD_Ini2Obj(Ini_File){ 
	; return 2D-array from INI-file: https://www.autohotkey.com/boards/viewtopic.php?p=256940&sid=7630b8496d3e9b93f364b58ecbf35914#p256940
	; Key Value Pair Read from Ini Files
	Result := []
	IniRead, SectionNames, % INI_File
	for each, Section in StrSplit(SectionNames, "`n") {
		IniRead, OutputVar_Section, % INI_File, % Section 
		for each, Haystack in StrSplit(OutputVar_Section, "`n")
			RegExMatch(Haystack, "(.*?)=(.*)", $)
            , Result[Section, $1] := $2
	}
	Return Result
}
DMD_RunShortcut(Program, Icon :="C:\Program Files\AutoHotkey\AutoHotkey.exe", IconNumber :=2){
	SplitPath, Program, Name, Dir, EXT, NNE, Drive                                                                                              ;~ for each item in array, split the path to corresponding variables
	ShortcutDir := "C:\AHK Scripts\_DMD Scripts\Run Shortcuts"
	Shortcut    := ShortcutDir . "\" . NNE . ".lnk"
	UI_Path     := (A_PtrSize != 4 ? "C:\Program Files\AutoHotkey\AutoHotkeyU64_UIA.exe" : "C:\Program Files\AutoHotkey\AutoHotkeyA32_UIA.exe") ;~ If AHK in 64 than run 64, else run 32 bit
	If FileExist(Shortcut){
		FileGetShortcut, % Shortcut, vTarget, vDir, vArgs, vDesc, vIcon, vIconNum, vRunState
		if StrReplace(vArgs, chr(34), "") != Program                                                                                           ;~ Does the path = the destintation of the shortcut (removing the double quotes from command)
		{
			FileDelete, % Shortcut
			While FileExist(Shortcut)                                                                                                         ;~ Wait for file to be removed before creating
				Sleep, 100			
			FileCreateShortcut, % UI_Path, % Shortcut, % Dir, % Chr(34) Program Chr(34),, % Icon,, % IconNumber                               ;~ Shortcut UI has to go first to tell it to launch UI on to target Shortcut
			While !FileExist(Shortcut)                                                                                                        ;~ Wait til file exists to Run
				Sleep, 100
		}
		Run, % Shortcut
		Return                                                                                                                                 ;~ Makes it so if the file exist the script ends here, otherwise it'll continue below
	}
	FileCreateShortcut, % UI_Path, % Shortcut, % Dir, % Chr(34) Program Chr(34),, % Icon,, % IconNumber                                         ;~ Shortcut UI has to go first to tell it to launch UI on to target Shortcut
	While !FileExist(Shortcut)                                                                                                                  ;~ Wait til file exists to Run
		Sleep, 100
	Run, % Shortcut
}
DMD_AppPath(App, RegExMatch:= 1){
	vApp       := App
	oFolder    := ComObjCreate("Shell.Application").NameSpace("shell:Appsfolder")
	oUser_Apps := []
	for item, value in oFolder.Items
	{
		vUser_Apps .= item.name "Path is " item.path "`n" ;~ Throw Apps in a String
		oUser_Apps[item.name] .= item.path                ;~ Throw Apps into a Object to be called Later
	}	
	if (RegExMatch == 1)
	{
		for Key, Value in oUser_Apps
			if (Key ~= "i)" vApp)                         ;~f If App contains XXX, than give me path
				vApp := Value "`n"
	}	
	if (RegExMatch == 0)
	{
		for Key, Value in oUser_Apps
			if (Key == vApp)                              ;~ If App contains XXX, than give me path
				vApp := Value "`n"
	}
	if (App == vApp)
		Return % "Can't find what you're looking for"
	else
		Return vApp
}
DMD_Columnize(data, delim="csv", justify=1, pad=" ", colsep=" | "){ ;~ Original -- https://www.autohotkey.com/boards/viewtopic.php?f=6&t=53		
	widths:=[]
	dataArr:=[]
	
	if (instr(justify, "|"))
		colMode:=strsplit(justify, "|")
	else
		colMode:=justify
	; make the arrays and get the total rows and columns
	loop, parse, data, `n, `r
	{
		if (A_LoopField="")
			continue
		row:=a_index
		
		if (delim="csv")
		{
			loop, parse, A_LoopField, csv
			{
				dataArr[row, a_index]:=A_LoopField
				if (dataArr.maxindex()>maxr)
					maxr:=dataArr.maxindex()
				if (dataArr[a_index].maxindex()>maxc)
					maxc:=dataArr[a_index].maxindex()
			}
		}
		else
		{
			dataArr[a_index]:=strsplit(A_LoopField, delim)
			if (dataArr.maxindex()>maxr)
				maxr:=dataArr.maxindex()
			if (dataArr[a_index].maxindex()>maxc)
				maxc:=dataArr[a_index].maxindex()
		}
	}
	; get the longest item in each column and store its length
	loop, %maxc%
	{
		col:=a_index
		loop, %maxr%
			if (strLen(dataArr[a_index, col])>widths[col])
				widths[col]:=strLen(dataArr[a_index, col])
	}
	; the main goodies.
	loop, %maxr%
	{
		row:=a_index
		loop, %maxc%
		{
			col:=a_index
			stuff:=dataArr[row,col]
			len:=strlen(stuff)
			difference:=abs(strlen(stuff)-widths[col])
			
			; generate a repeating string about the length of the longest item
			; in the column.
			loop, % ceil(widths[col]/((strlen(pad)<1) ? 1 : strlen(pad)))
				padSymbol.=pad
			
			if (isObject(colMode))
				justify:=colMode[col]
			; justify everything correctly.
			; 3 = center, 2= right, 1=left.
			if (strlen(stuff)<widths[col])
			{
				if (justify=3)
					stuff:=SubStr(padSymbol, 1, floor(difference/2)) . stuff
					. SubStr(padSymbol, 1, ceil(difference/2))
				else
				{
					if (justify=2)
						stuff:=SubStr(padSymbol, 1, difference) stuff
					else ; left justify by default.
						stuff:= stuff SubStr(padSymbol, 1, difference) 
				}
			}
			out.=stuff ((col!=maxc) ? colsep : "")
		}
		out.="`r`n"
	}
	stringTrimRight, out, out, 2 ; remove the last blank newline
	return out
}
DMD_Run(Path, WorkingDir := "", Options := "UseErrorLevel", Admin := 0){
	for Key, Value in {Options:["Max","Min","Hide","UseErrorLevel"]}
		if(!Options[Key])
			Options[Key] := Value
	Run, % (Admin == 1 ? "*RunAs " : "") Path, % WorkingDir, % Options, PID	
	if ErrorLevel
		Msgbox, 48, % "ERROR "A_LastError, % DMD_GetErrorStr(A_LastError)
}
DMD_GetErrorStr(ErrNum){
	VarSetCapacity(ErrorStr, 1024)
	DllCall("FormatMessage", "UINT", 0x1000, "UINT", NULL, "UINT", ErrNum, "UINT", 0, "Str", ErrorStr, "UINT", 1024, "str", "")
	return ErrorStr
}
DMD_AutoInsert(Symbol){
	RestoreClip := ClipboardAll
	Clipboard := "" 									;~ Remove anything previously from clipboard
	ControlGetFocus, vCtlClassNN, A
	ControlGet, hCtl, Hwnd,, % vCtlClassNN, A
	SendInput, ^x
	;~ SendMessage, 0x0300,,,, % "ahk_id " hCtl 				;~ WM_Cut := 0x300 Needed the extra 0 in the beginning
	Clipwait, 1
	If (Clipboard = ""){
		Clipboard:= RestoreClip
		Return
	}
	/*
		else if (Symbol:=chr(91)){
			Clipboard:=Symbol Clipboard "]"
			SendInput, ^v
			Sleep, 50
			Clipboard:= RestoreClip
			Return
		}
		else if (Symbol:=chr(40)){
			Clipboard:=Symbol Clipboard ")"
			SendInput, ^v
			Sleep, 50
			Clipboard:= RestoreClip
			Return
		}
		else if (Symbol:=chr(123)){
			Clipboard:=Symbol Clipboard "}"
			SendInput, ^v
			Sleep, 50
			Clipboard:= RestoreClip
			Return
		}
		else
	*/
	Clipboard := Symbol Clipboard Symbol
	SendInput, ^v
	;~ SendMessage, 0x302,,,, % "ahk_id " hCtl 				;~ WM_PASTE := 0x302 Didn't need the extra 0 in beginning
	Sleep, 50
	Clipboard := RestoreClip
	Return
}
DMD_GetGuiInfo(){
	Gui, +LastFound
	WinGetPos, x, y, w, h
	Return {x:x,y:y,w:w,h:h}
}
WinWaitActive(vWindow, SN := 100){
	start := A_TickCount
	while(!WinActive(vWindow) && A_TickCount-start <= 30000){ ;~ While Window is not active & 30 seconds hasn't ellasped.
		WinActivate, % vWindow
		Sleep % SN
	}	
}
DMD_ReloadScript(Script){ ;~ If Target Script is being ran as ADMIN then this function has to be ran as ADMIN
	DetectHiddenWindows, On                                                             ;~ Detect hidden windows
	SetTitleMatchMode, RegEx                                                            ;~ Find window titles by regex
	(Script ~= "mi).ahk$" ? Script := Script : Script := Script ".ahk")                 ;~ Ensures Script var has ".ahk" to end of Script title
	WinGet, PID, PID, % "i)^.+\\" EscapeCharsRegEx(Script) " - AutoHotkey v.+$"         ;~ Get the PID of the window with the title matching the format "*\Scriptname - AutoHotkey v*"
	;~ WinGet, hWnd, ID, % "i)^.+\\" CleanEx(Script) " - AutoHotkey v.+$"               ;~ Get the ID of the window with the title matching the format "*\Scriptname - AutoHotkey v*"
	;~ MsgBox, % Script "'s PID is:`n" PID
	vScript := "ahk_pid " PID
	;------"WinAPI Command","Unit" HWND,  UNIT  , MSG,   UNIT,   PPARM, UNIT  , LPARAM  ;~ Has to be HWND ID not PID, so fix the WinGet
	;~ DllCall("PostMessage", "UInt", hWnd, "UInt", 0x111, "UInt", 65303, "UInt", 0)    ;~ Reload with DllCall()
	;~ SendMessage, 0x111, 65400, 0,, % "ahk_pid " PID ,,,, 1                           ;~ Reload with SendMessage
     PostMessage, 0x111, 65303, 0,, % "ahk_pid " PID ,,,, 1                              ;~ Reload with PostMessage
	DetectHiddenWindows, Off                                                            ;~ Detect hidden windows
}
EscapeCharsRegEx(string){
	static escapist := "([\\.*?+|[{}()^\]])"
	return RegExReplace(string, escapist, "\$1")
}
; ------- Cloud Based Pathways ------- Pulled from QAP Sourcecode ---------
DMD_DropboxPath(){
	o_Settings.UserVariables.strUserVariablesList.IniValue := ""
	if FileExist(EnvVars("%LOCALAPPDATA%\Dropbox\info.json"))
		FileRead, strDropboxJsonFileContent, % EnvVars("%LOCALAPPDATA%\Dropbox\info.json")
	else if FileExist(EnvVars("%APPDATA%\Dropbox\info.json"))
		FileRead, strDropboxJsonFileContent, % EnvVars("%APPDATA%\Dropbox\info.json")
	;~ RegExMatch(strDropboxJsonFileContent, "(?<=\x22path\x22: \x22).*(?=\x22,)", oMatch)
	;~ return StrReplace(oMatch, "\\", "\")
	return cJson.Loads(strDropboxJsonFileContent).personal.path ; personal not business dropbox
}
DMD_GDrivePath(){
	o_Settings.UserVariables.strUserVariablesList.IniValue := ""
	vPath1 := EnvVars("%LOCALAPPDATA%\Google\Drive\user_default\sync_config.db")
	vPath2 := EnvVars("%LOCALAPPDATA%\Google\DriveFS\migration\bns_config\user_default\sync_config.db")
	strGoogleDriveDbFile := (!FileExist(vPath1) ? vPath2 : vPath1)
	if FileExist(strGoogleDriveDbFile)
	{
		strGoogleDriveDbFileCopy := A_Temp . "\Temp_GoogleDrive_Database.DB"
		FileCopy, %strGoogleDriveDbFile%, %strGoogleDriveDbFileCopy%, 1
		global o_GoogleDriveDb := New SQLiteDb
		if o_GoogleDriveDb.OpenDb(strGoogleDriveDbFileCopy)
		{
			strSQLGoogleDriveQuery := "SELECT data_value FROM data WHERE entry_key='local_sync_root_path'"
			If o_GoogleDriveDb.Query(strSQLGoogleDriveQuery, objGoogleDriveRecordSet)
			{
				objGoogleDriveRecordSet.Next(objGoogleDriveRow)
				o_Settings.UserVariables.strUserVariablesList.IniValue .= "{GoogleDrive}=" . SubStr(objGoogleDriveRow[1], 5) . "|"
			}
			objGoogleDriveRecordSet.Free()
			o_GoogleDriveDb.CloseDb()
		}
	}
	return SubStr(objGoogleDriveRow.1, 5)
}
DMD_OneDrivePath(){
	Loop, parse, % "Software\Microsoft\OneDrive|Software\Microsoft\Windows\CurrentVersion\SkyDrive|Software\Microsoft\SkyDrive", |
	{
		RegRead, strOneDrive, HKCU, %A_LoopField%, UserFolder
		if StrLen(strOneDrive) and FileExist(strOneDrive)
		{
			o_Settings.UserVariables.strUserVariablesList.IniValue .= "{OneDrive}=" . strOneDrive . "|"
			break
		}
	}
	return strOneDrive
}
EnvVars(str){
	str := ExpandUserVariables(str)
	if sz:=DllCall("ExpandEnvironmentStrings", "uint", &str, "uint", 0, "uint", 0)
	{
		VarSetCapacity(dst, A_IsUnicode ? sz*2:sz)
		if DllCall("ExpandEnvironmentStrings", "uint", &str, "str", dst, "uint", sz)
			return ExpandUserVariables(dst)
	}
	return str
}
ExpandUserVariables(str){
	loop, parse, % o_Settings.UserVariables.strUserVariablesList.IniValue, |
		if (StrLen(A_LoopField) and SubStr(A_LoopField, 1, 1) ="{")
		{
			saUserVariable := StrSplit(A_LoopField, "=")
			if (SubStr(saUserVariable[1], 1, 1) = "{" and SubStr(saUserVariable[1], StrLen(saUserVariable[1]), 1) = "}")
				str := StrReplace(str, saUserVariable[1], saUserVariable[2])
		}
	return str
}