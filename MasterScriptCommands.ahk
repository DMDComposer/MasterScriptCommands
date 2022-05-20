#Include <Default_Settings>
#Include <Neutron>
#Include <cJson>
#Include includes\mscUtilities.ahk
#Include includes\mscSearchEngine.ahk
#Include includes\mscRunAHKCommand.ahk
; NOTE: Must run on admin to enable MSC toggle on all windows
; NOTE: If using WinWait or While loop to wait for something, it could freeze up MSC. Set a limit to the time wait.
; TODO: Add dark/light mode depending on time for background colors
if (!A_IsAdmin) { ;http://ahkscript.org/docs/Variables.htm#IsAdmin
	Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
	ExitApp
}

class MasterScriptCommands {

}
msc := new MasterScriptCommands()
; TODO: ResetMSC needs to recenter GUI Spawn if user moved it
; Create a new NeutronWindow and navigate to our HTML page
oFinalCommandsList := getListOfCommands()
neutron := new NeutronWindow()
neutron.Load("includes/index.html")
neutron.wnd.onReady(event)             ; Prepping intellisense, gather list of commands aka getDB()
neutron.Gui("+LabelMSCNeutronGui")
global wndToggle     := 1
	 , wndUID        := "ahk_id " neutron.UID()
	 , wndPos        := getSearchWndPos(neutron)
	 , int           := int
	 , Ico   		 := A_ScriptDir "\Icon.ico"
	 , MSC_Search    := []
	 , vIni_Dir_Path := A_Dropbox "\AHK Scripts\_DMD Scripts\Hotstring Directory Paths\Directory Paths.ini"
	 , oDir_Paths    := DMD_Ini2Obj(vIni_Dir_Path)
	 , oDirs         := oDir_Paths.Directory_Paths
	 , oIcons        := oDir_Paths.Icon_Paths
setMSCIcons(wndUID)
Gui +LastFound +OwnDialogs +AlwaysOnTop ; keep MSC AlwaysOnTop
enableMSCHotkeys()
t("Master Script Commands")
return

; NOTE: Summon / Dismiss MSC Neutron Window
RAlt::toggleMSC(neutron)

getWndDefaultPos(neutron, wndUID) {
	DetectHiddenWindows, On
	WinGetPos, x, y, w, h, % wndUID
	DetectHiddenWindows, Off
	return {x:x,y:y,w:w,h:h}
}
setMSCSearchParam(neutron, event) {
	toggleMSC(neutron)
	mscSearchEngine.mscAddElements(event)
}
enableMSCHotkeys() {
	Hotkey, IfWinActive, % wndUID
	Hotkey, Down, highlightNextDiv
	Hotkey, Up, highlightPrevDiv
}
getCommand(neutron, ByRef event) {
	; need to create list from MSC
	global oFinalCommandsList
		 , MasterScriptCommands
		 , wndUID
	oCommandsList := []
	for key,value in oFinalCommandsList {
		oCommandsList.push(value.command)
	}
	for key,value in oCommandsList {
			
		if (event = value || oDir_PathsTrue(event)) {
			MasterScriptCommands := event
			resetMSCWnd(neutron, getWndDefaultPos(neutron, wndUID))
			Gosub, setCommands

			; need to reset event otherwise infinite loop with oDirs_PathsTrue()
			event := ""
		}
	}
}

getCommandTotal(neutron) {
	global oFinalCommandsList
	return oFinalCommandsList.Length()
}
getDB(neutron, event) {
	/*
	; create object like below from MSC commands
	global oObj := [{"command":"command1","comment":"comment1"}
		    ,{"command":"command2","comment":"comment2"}
		    ,{"command":"command3","comment":"comment3"}
		    ,{"command":"command4","comment":"comment4"}
		    ,{"command":"command5","comment":"comment5"}]
	*/
	global oFinalCommandsList
	Clipboard := cJson.Dumps(oFinalCommandsList)
	return cJson.Dumps(oFinalCommandsList)
}
getListOfCommands() {
	oCommands := {}
	Loop, Read, % A_ScriptDir "\Includes\userCommands.ahk"
	{
		StringCaseSense, Off 
		If SubStr(A_LoopReadLine, 1, 1) != ";" Continue ; Do not display commented commands
	    If A_LoopReadLine contains % "Case "
	    {
	        Command := RegExMatch(A_LoopReadLine,"iO)(?<=\x22).*(?=\x22)", oCommand)
	        Command := oCommand.Value
	        mPos    := RegExMatch(Command, "O)\s?,\s?", "$1") ; If multiple commands, just grab first one and remove extra "
	        Comment := RegExMatch(A_LoopReadLine,"iO);(\s?).*", oComment) ; Grab the comment inside ""
	        Comment := RegExReplace(oComment.Value, ";~?\s?", "")
	        if (!Command)
	            Continue
	        if (mPos) {
				; ex: Case: "entry1", "entry2":
				; if errors with mulltiple command list, check below for Regex/Substr
	            mCommand1 := SubStr(Command,1,mPos-2)
	            mCommand1 := RegExReplace(mCommand1, "\x22\s?,?\s\x22?", "")
	            mCommand2 := SubStr(Command,mPos+3,StrLen(Command))
	            ; mCommand2 := RegExReplace(mCommand2, "\x22?\s?,?\s\x22?", "")
	            oCommands[mCommand1] := Comment
	            oCommands[mCommand2] := Comment
	        }
	        if (!mPos)
	            oCommands[Command] := Comment
	    }
	}
	oFinalCommandsList := {}
	for key,value in oCommands {
	    oObj := {"command":"","comment":""}
	    oObj["command"] := key
	    oObj["comment"] := value
		oFinalCommandsList.push(oObj)
	}
	return oFinalCommandsList
}
getMSCTitle(MasterScriptCommands, Dir) {
	global oFinalCommandsList
	for key,value in oFinalCommandsList {
		if (value.command = MasterScriptCommands) {
			return value.command
		}
	}
}
getScrollIntDefault(neutron) {
	return (A_ScreenDPI > 96 ? 8 : 12)
}
getSearchWndPos(neutron) {
	vW := neutron.wnd.eval("$('.search').width()")
	vH := neutron.wnd.eval("$('.search').height()")
	; vPos := "w" vW " h" vH " x" vX " y" vY
	vPos := "w" vW " h" vH
	return vPos
}
highlightNextDiv() {
	global int, neutron
	(int < 0 ? int := "" : int)
	int++
	; Notify().AddWindow(A_ThisHotkey, {Title: int-1 })
	if (neutron.wnd.Eval("$('#search').val()") != "")
		neutron.wnd.Eval("highlightNextDiv(" int-1 ")")
}
highlightPrevDiv() {
	global int, neutron
	(int < 0 ? int := "" : int)
	int--
	; Notify().AddWindow(A_ThisHotkey, {Title: int })
	if (neutron.wnd.Eval("$('#search').val()") != "")
		neutron.wnd.Eval("highlightPrevDiv(" int ")")
}
mscEscapeKey(neutron) {
	neutron.Destroy()
	ExitApp
}
oDir_PathsTrue(event) {
	global oDirs
	return (oDirs.HasKey(event) || oDirs.HasKey("dir " MasterScriptCommands) ? true : false)
}
reloadScript(neutron) {
	Reload
}
resetMSCWnd(neutron, ByRef wndDefPos) {
	global int, wndUID
	DetectHiddenWindows, On
	WinGetPos, x, y, w, h, % wndUID
	if (x != wndDefPos.x)
		WinMove, % wndUID,, % wndDefPos.x, % wndDefPos.y, % wndDefPos.w, % wndDefPos.h
	DetectHiddenWindows, Off
	if (int >= 0)
		neutron.wnd.Eval("resetHighlightedDiv(" int ")")
	neutron.wnd.Eval("resetSearchAttributes()")
	neutron.wnd.Eval("$('#search').val('')")
	neutron.wnd.Eval("$('.mscIcon').css({'animation':'none'})")
	neutron.Hide()
	int := 0 
} 
runIEChooser(neutron) { ; with F12 open debug options for neutron
	Run % A_ComSpec "\..\F12\IEChooser.exe",
	WinWaitActive, ahk_exe IEChooser.exe
	WinSet, AlwaysOnTop, On, ahk_exe IEChooser.exe
}
setMSCIcons(wndUID) { ; Set Icon of Script in Taskbar & Tray Icon if Swal exists
	global Ico
	DetectHiddenWindows, On
	If WinExist(wndUID) {
		Menu, Tray, Icon, % Ico, 1 ; Set Icon of Script in Taskbar
		hIcon := DllCall( "LoadImage", UInt,0, Str,Ico, UInt,1, UInt,0, UInt,0, UInt,0x10 )
		SendMessage, 0x80, 0, hIcon ,, % wndUID  ; Small Icon
		SendMessage, 0x80, 1, hIcon ,, % wndUID  ; Big Icon
	}
	DetectHiddenWindows, Off
}
toggleMSC(neutron) {
	global wndToggle
		 , wndPos
		 , wndUID
	static wndDefPos := wndDefPos
	wndToggle := (WinExist(wndUID) ? 1 : 0)
	Switch wndToggle
	{
		Case 0: {
			neutron.Show(wndPos)
			wndDefPos := getWndDefaultPos(neutron, wndUID)
			neutron.wnd.Eval("$('#search').focus()")
			; neutron.wnd.Eval("$('.mscIcon').playKeyframe('12s linear infinite')") ; not supported with Legacy JS
			neutron.wnd.Eval("$('.mscIcon').css({'animation-delay': '4s;','animation':'mscIconSpin 12s linear infinite;'})")
			wndToggle := 1
			; WinGetPos, x,y,w,h, % wndUID
		}
		Case 1: {
			resetMSCWnd(neutron, wndDefPos)
			; neutron.wnd.Eval("$('.mscIcon').pauseKeyframe()") ; not supported with Legacy JS
			wndToggle := 0
		}
	}
}
updateWndSize(neutron, ByRef wndW, ByRef wndH, ByRef mscInput) {
	mscInput != "" ? wndH := 290+137 : wndH := 137
	; Notify().AddWindow(wndH, {Title:mscInput})
	; Swal.toast(wndH,{title:mscInput})
	neutron.Show("h" wndH+10)
}
runAHKCommand() {
	global neutron
	
	neutron.wnd.Eval("$('.mscIcon').attr('src','" mscUtilities.escapeBackSlash("../Icons/AHK.ico") "')")
	neutron.wnd.Eval("$('.mscTitle').text('AHK Custom Command')")
	neutron.wnd.Eval("$('.mscTitle').css('color', '#00FF00')")
	neutron.wnd.Eval("$('#search:focus').css({'border-color': '#00FF00', 'box-shadow': 'inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px #00FF00'})")
	
	; change ID of search to enable search functions
	neutron.wnd.Eval("$('#search').attr('id','mscRunAHKCommandInput')")
	; Show Newly Changed Window
	toggleMSC(neutron)
	; Focus new Search Edit Field
	neutron.wnd.Eval("$('#mscRunAHKCommandInput').focus()")
	return
}
getMSCRunAHKCommand(neutron,command) {
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

; NOTE: Have to use a goSub because their are functions within the Case statements. Otherwise errors out with nested functions
setCommands:
#Include Includes\userCommands.ahk
return

; testing purposes function
xxyy(neutron,event) {
	Notify().AddWindow(event, {Title:"Title"})
	; t(event)
}