#Include <Default_Settings>
#Include <Neutron>
#Include <cJson>
;
; NOTE: Must run on admin to enable MSC toggle on all windows
if (! A_IsAdmin){ ;http://ahkscript.org/docs/Variables.htm#IsAdmin
	Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
	ExitApp
}

; TODO: ResetMSC needs to recenter GUI Spawn if user moved it
; TODO: Highlight Arrow Keys, Scrollbar Needs to Follow to bottom of list

; Create a new NeutronWindow and navigate to our HTML page
oFinalCommandsList := getListOfCommands()
; NOTE: Create neutron window & attributes
neutron := new NeutronWindow()
neutron.Load("index.html")
neutron.wnd.onReady(event)             ; Sending the Swal Msg Params for the Popup Msg
neutron.Gui("+LabelMSCNeutronGui")
global wndToggle     := 0
	 , wndPos        := getSearchWndPos(neutron)
	 , wndUID        := "ahk_id " neutron.UID()
	 , int           := int
	 , MSC_Search    := []
	 , vIni_Dir_Path := A_Dropbox "\AHK Scripts\_DMD Scripts\Hotstring Directory Paths\Directory Paths.ini"
	 , oDir_Paths    := DMD_Ini2Obj(vIni_Dir_Path)
	 , oDirs         := oDir_Paths.Directory_Paths
	 , oIcons        := oDir_Paths.Icon_Paths
setMSCIcons(wndUID)
Gui +LastFound +OwnDialogs +AlwaysOnTop ; keep MSC AlwaysOnTop
; neutron.Show(wndPos)
wndToggle := 1
enableMSCHotkeys()
t("Master Script Commands")
return

; NOTE: Summon / Dismiss MSC Neutron Window
RAlt::
toggleMSC(neutron)
return

getMSCCommand(neutron, event) {
	; s(event)
	global gui_SearchEdit := event
	toggleMSC(neutron)
	Gosub, gui_search_add_elements
}
enableMSCHotkeys() {
	Hotkey, IfWinActive, % wndUID
	Hotkey, Down, highlightNextDiv
	Hotkey, Up, highlightPrevDiv
}
escapeBackSlash(string){
	return RegExReplace(string, "\\", "\\$1")
}
getCommand(neutron, ByRef event) {
	; need to create list from MSC
	global oFinalCommandsList
		 , MasterScriptCommands
	oCommandsList := []
	for key,value in oFinalCommandsList {
		oCommandsList.push(value.command)
	}
	for key,value in oCommandsList {
		if (event = value || oDir_PathsTrue(event)) {
			MasterScriptCommands := event
			resetMSCWnd(neutron)
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
	        ; mCommand  := RegExReplace(SubStr(Command,1,InStr(Command,"|")-2), "O)\x22", "$1") ; If multiple commands, just grab first one and remove extra "
	        mPos    := RegExMatch(Command, "O)\s?,\s?", "$1") ; If multiple commands, just grab first one and remove extra "
	        Comment := RegExMatch(A_LoopReadLine,"iO);(\s?).*", oComment) ; Grab the comment inside ""
	        Comment := RegExReplace(oComment.Value, ";~?\s?", "")
	        if (!Command)
	            Continue
	        if (mPos) {
	            mCommand1 := SubStr(Command,1,mPos-2)
	            mCommand1 := RegExReplace(mCommand1, "\x22?\s?,?\s?\x22?", "")
	            mCommand2 := SubStr(Command,mPos,StrLen(Command))
	            mCommand2 := RegExReplace(mCommand2, "\x22?\s?,?\s?\x22?", "")
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
getMSCTitle(MasterScriptCommands, Dir){
	global oFinalCommandsList
	for key,value in oFinalCommandsList {
		if (value.command = MasterScriptCommands) {
			return value.command
		}
	}
}
getSearchWndPos(neutron){
	vW := neutron.wnd.eval("$('.search').width()")
	vH := neutron.wnd.eval("$('.search').height()")
	; vPos := "w" vW " h" vH " x" vX " y" vY
	vPos := "w" vW " h" vH
	return vPos
}
highlightNextDiv() {
	global int, neutron 
	(int <i 0 ? 0 : int)
	int++
	; Notify().AddWindow(A_ThisHotkey, {Title: int-1 })
	neutron.wnd.Eval("highlightNextDiv(" int-1 ")")
}
highlightPrevDiv() {
	global int, neutron
	(int <i 0 ? 0 : int)
	int--
	; Notify().AddWindow(A_ThisHotkey, {Title: int })
	neutron.wnd.Eval("highlightPrevDiv(" int ")")
}
mscEscapeKey(neutron) {
	neutron.Destroy()
	ExitApp
}
mscSearch(oOptions*) {
	; Title,Subtitle := "What would you like to search?",Color := "",Icon := ""
	global neutron
	static oKeys := ["title","subTitle","icon","color","background"]
	      ,searchParams := {title:"Custom Search"
						   ,subTitle:"What would you like to search?"
						   ,icon:"./Icons/AHK.ico"
						   ,color:"#00FF00"
						   ,background:"#00FF00"}
	
	for key,value in oOptions.1 {
		Loop, % oKeys.Length() {
			if (key = oKeys[A_Index])
				searchParams[oKeys[A_Index]] := value
		}
	}
	; neutron.wnd.Eval("$('.mscIcon').css('background','url(""" searchParams.icon """) no-repeat center center')")
	neutron.wnd.Eval("$('.mscIcon').attr('src','" escapeBackSlash(searchParams.icon) "')")
	neutron.wnd.Eval("$('.mscTitle').text('" searchParams.title "')")
	neutron.wnd.Eval("$('.mscTitle').css('color', '" searchParams.color "')")
	neutron.wnd.Eval("$('#search:focus').css({'border-color': '" searchParams.color "', 'box-shadow': 'inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px " searchParams.color "'})")
	
	; change ID of search to enable search functions
	neutron.wnd.Eval("$('#search').attr('id','mscSearchInput')")
	; Show Newly Changed Window
	toggleMSC(neutron)
	; Focus new Search Edit Field
	neutron.wnd.Eval("$('#mscSearchInput').focus()")
	return
}
mscSearchUrls(url) {
	global MSC_Search
	MSC_Search.Push(url)
}
oDir_PathsTrue(event) {
	global oDirs
	return (oDirs.HasKey(event) || oDirs.HasKey("dir " MasterScriptCommands) ? true : false)
}
resetMSCWnd(neutron) {
	global int
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
	If WinExist(wndUID) {
		Ico   := A_LineFile "\..\Icon.ico"
		Menu, Tray, Icon, % Ico, 1 ; Set Icon of Script in Taskbar
		hIcon := DllCall( "LoadImage", UInt,0, Str,Ico, UInt,1, UInt,0, UInt,0, UInt,0x10 )
		SendMessage, 0x80, 0, hIcon ,, % wndUID  ; Small Icon
		SendMessage, 0x80, 1, hIcon ,, % wndUID  ; Big Icon
	}
}
toggleMSC(neutron) {
	global wndToggle
		 , wndPos
		 , wndUID
	DetectHiddenWindows, Off
	wndToggle := (WinExist(wndUID) ? 1 : 0)
	Switch wndToggle
	{
		Case 0: {
			neutron.Show(wndPos)
			neutron.wnd.Eval("$('#search').focus()")
			; neutron.wnd.Eval("$('.mscIcon').playKeyframe('12s linear infinite')") ; not supported with Legacy JS
			neutron.wnd.Eval("$('.mscIcon').css({'animation-delay': '4s;','animation':'mscIconSpin 12s linear infinite;'})")
			wndToggle := 1
			; WinGetPos, x,y,w,h, % wndUID
		}
		Case 1: {
			resetMSCWnd(neutron)
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

; NOTE: Have to use a goSub because their are functions within the Case statements. Otherwise errors out with nested functions
setCommands:
#Include Includes\userCommands.ahk
return

gui_search_add_elements:
for key, value in MSC_Search {
	vURL := StrReplace(value, "REPLACEME", uriEncode(gui_SearchEdit))
	DMD_Run(vURL)
	Search_Title := RegExReplace(value, "s).*?(\d{12}).*?(?=\d{12}|$)", "$1`r`n")
	If (Title = "" ? Title := Search_Title : Title := Title)	
		t("<i style='font-size:0.75rem'>" vURL "</i>",{title:gui_SearchEdit,time:3000,stack:1}) 
}
MSC_Search := [] ; reset for adding search urls into MSC_Search
return

runAHKCommand() {
	global neutron
	
	neutron.wnd.Eval("$('.mscIcon').attr('src','" escapeBackSlash("./Icons/AHK.ico") "')")
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
	static tmpScriptDir := A_ScriptDir "\Includes\tempRunAHKCommand.ahk"
		 , header := "#Include <Default_Settings>`n"
		 , footer := "`nExitApp"
	while (FileExist(tmpScriptDir))
		FileDelete, % tmpScriptDir
	FileAppend, % header . command . footer, % tmpScriptDir
	while (!FileExist(tmpScriptDir))
		Sleep, 10
	Run % tmpScriptDir,,UseErrorLevel,PID
	if ErrorLevel
		t(A_LastError)
}